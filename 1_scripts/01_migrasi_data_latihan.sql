DROP TABLE IF EXISTS trips CASCADE;
DROP TABLE IF EXISTS routes CASCADE;

CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    route_name TEXT NOT NULL
);

CREATE TABLE trips (
    trip_id TEXT NOT NULL,
    route_id INT NOT NULL REFERENCES routes(route_id),
    started_at TIMESTAMPTZ NOT NULL,
    status TEXT NOT NULL
);

SELECT create_hypertable('trips', 'started_at');

CREATE INDEX IF NOT EXISTS idx_trips_route_started_at
    ON trips (route_id, started_at DESC);

INSERT INTO routes (route_id, route_name) VALUES
(12, 'Koridor Pusat-Timur'),
(15, 'Koridor Kampus-Stasiun'),
(18, 'Koridor Pasar-Kota');

INSERT INTO trips (trip_id, route_id, started_at, status) VALUES
('T001', 12, '2026-11-02 07:10:00+07', 'completed'),
('T002', 15, '2026-11-02 07:25:00+07', 'completed'),
('T003', 12, '2026-11-03 08:05:00+07', 'delayed'),
('T004', 18, '2026-10-29 06:50:00+07', 'completed'),
('T005', 12, '2026-11-05 17:20:00+07', 'completed'),
('T006', 15, '2026-11-06 09:15:00+07', 'cancelled');