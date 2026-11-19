DROP ROLE IF EXISTS report_user;
CREATE ROLE report_user LOGIN PASSWORD '<GANTI_DENGAN_PASSWORD_KUAT>';

GRANT CONNECT ON DATABASE postgres TO report_user;
GRANT USAGE ON SCHEMA public TO report_user;
GRANT SELECT ON TABLE public.routes, public.trips TO report_user;

SELECT grantee, table_schema, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'report_user';

REVOKE SELECT ON TABLE public.routes, public.trips FROM report_user;