-- Postgres command to insert the values to the CSV file.
COPY mas.panchayats(district_id,type,name)
    FROM '/var/lib/pgsql/corporation_districts.csv'-- <- if CSV file is not avail in this location then the permission error may be arrived.
    DELIMITER ','
    CSV HEADER;

-- **** Command to fix corrupted index sequence ****

-- Execute then below command when the insertion error happens on serial column
CREATE SEQUENCE public.example_id_seq1;
ALTER TABLE public.example ALTER COLUMN id SET DEFAULT nextval('public.example_id_seq1');
SELECT setval('public.example_id_seq1', MAX(id)) FROM public.example;

-- Command to check all the sequences and its last values.
select *
from pg_sequences;