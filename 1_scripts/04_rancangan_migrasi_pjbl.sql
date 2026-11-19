CREATE EXTENSION IF NOT EXISTS timescaledb;

DROP TABLE IF EXISTS patrol_logs CASCADE;
DROP TABLE IF EXISTS patrol_areas CASCADE;

CREATE TABLE patrol_areas (
    area_id INT PRIMARY KEY,
    area_name VARCHAR(100) NOT NULL,
    sector_zone VARCHAR(50) NOT NULL
);

CREATE TABLE patrol_logs (
    log_id VARCHAR(20) NOT NULL,
    area_id INT NOT NULL REFERENCES patrol_areas(area_id),
    reported_at TIMESTAMPTZ NOT NULL,
    incident_type VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL
);

SELECT create_hypertable('patrol_logs', 'reported_at');

CREATE INDEX IF NOT EXISTS idx_patrol_logs_area_time
    ON patrol_logs (area_id, reported_at DESC);

INSERT INTO patrol_areas (area_id, area_name, sector_zone) VALUES
(1, 'Blok Pinus Utara - Nongko Ijo', 'Zona A'),
(2, 'Blok Sungai & Mata Air', 'Zona B');

INSERT INTO patrol_logs (log_id, area_id, reported_at, incident_type, status) VALUES
('LOG-001', 1, '2026-11-01 08:15:00+07', 'Patroli Rutin', 'Aman'),
('LOG-002', 1, '2026-11-01 14:30:00+07', 'Pohon Tumbang', 'Ditangani'),
('LOG-003', 2, '2026-11-02 09:00:00+07', 'Patroli Rutin', 'Aman'),
('LOG-004', 1, '2026-11-03 16:45:00+07', 'Titik Rawan Api', 'Siaga');

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    p.log_id,
    p.reported_at,
    a.area_name,
    p.incident_type,
    p.status
FROM patrol_logs AS p
JOIN patrol_areas AS a
    ON a.area_id = p.area_id
WHERE p.area_id = 1
  AND p.reported_at >= '2026-11-01 00:00:00+07'
ORDER BY p.reported_at;

SELECT
    time_bucket('1 day', p.reported_at) AS hari_patroli,
    a.area_name,
    COUNT(*) AS total_laporan
FROM patrol_logs AS p
JOIN patrol_areas AS a
    ON a.area_id = p.area_id
WHERE p.reported_at >= '2026-11-01 00:00:00+07'
GROUP BY hari_patroli, a.area_name
ORDER BY hari_patroli;

DROP ROLE IF EXISTS forest_reporter;
DROP ROLE IF EXISTS patrol_operator;

CREATE ROLE forest_reporter LOGIN PASSWORD '<GANTI_PASSWORD_REPORTER>';
CREATE ROLE patrol_operator LOGIN PASSWORD '<GANTI_PASSWORD_OPERATOR>';

GRANT CONNECT ON DATABASE postgres TO forest_reporter;
GRANT USAGE ON SCHEMA public TO forest_reporter;
GRANT SELECT ON TABLE public.patrol_areas, public.patrol_logs TO forest_reporter;

GRANT CONNECT ON DATABASE postgres TO patrol_operator;
GRANT USAGE ON SCHEMA public TO patrol_operator;
GRANT SELECT ON TABLE public.patrol_areas TO patrol_operator;
GRANT SELECT, INSERT, UPDATE ON TABLE public.patrol_logs TO patrol_operator;