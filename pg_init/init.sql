DROP TABLE IF EXISTS test_table;
CREATE TABLE public.test_table (
                                   id integer NOT NULL,
                                   name text NOT NULL
) WITH (oids = false);
INSERT INTO public.test_table (id, name) VALUES
                                             (1, 'event 1'),
                                             (2, 'event 2'),
                                             (3, 'event 3');