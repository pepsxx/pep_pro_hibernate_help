DROP TABLE IF EXISTS public.Person CASCADE;
DROP TABLE IF EXISTS public.Item CASCADE;
DROP TABLE IF EXISTS public.people CASCADE;
DROP TABLE IF EXISTS public.address CASCADE;
DROP TABLE IF EXISTS public.guest CASCADE;
DROP TABLE IF EXISTS public.room CASCADE;
DROP TABLE IF EXISTS public.room_guest CASCADE;
DROP TABLE IF EXISTS public.card_collection CASCADE;
DROP TABLE IF EXISTS public.card_collection_list CASCADE;
DROP TABLE IF EXISTS public.embed_people CASCADE;
DROP TABLE IF EXISTS public.embed_user CASCADE;
DROP TABLE IF EXISTS public.supper_class_child_one CASCADE;
DROP TABLE IF EXISTS public.supper_class_child_two CASCADE;
DROP TABLE IF EXISTS public.inherit_single_table_parent CASCADE;
DROP TABLE IF EXISTS public.inherit_joined_parent CASCADE;
DROP TABLE IF EXISTS public.inherit_joined_child_one CASCADE;
DROP TABLE IF EXISTS public.inherit_joined_child_two CASCADE;
DROP TABLE IF EXISTS public.inherit_parent CASCADE;
DROP TABLE IF EXISTS public.inherit_child_one CASCADE;
DROP TABLE IF EXISTS public.inherit_child_two CASCADE;
DROP SEQUENCE IF EXISTS public.inherit_parent_seq CASCADE;


CREATE TABLE Person
(
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL,
    age  INT CHECK ( age >= 0 )
);

CREATE TABLE Item
(
    id          BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    description VARCHAR NOT NULL,
    person_id   BIGINT  REFERENCES Person (id) ON DELETE SET NULL
);

CREATE TABLE people
(
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE address
(
    people_id BIGINT PRIMARY KEY REFERENCES people (id),
    street    VARCHAR NOT NULL
);

CREATE TABLE guest
(
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE room
(
    id     BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    number BIGINT NOT NULL
);

CREATE TABLE room_guest
(
    guest_id BIGINT REFERENCES guest (id),
    room_id  BIGINT REFERENCES room (id),
    PRIMARY KEY (guest_id, room_id)
);

CREATE TABLE card_collection
(
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE card_collection_list
(
    card_collection_id BIGINT  NOT NULL REFERENCES card_collection (id),
    list               VARCHAR NOT NULL
);

--embedded
CREATE TABLE embed_people
(
    id          BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    hobby       VARCHAR NOT NULL,
    first_name  VARCHAR NOT NULL,
    second_name VARCHAR NOT NULL,
    third_name  VARCHAR NOT NULL
);

CREATE TABLE embed_user
(
    id          BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nick_name   VARCHAR NOT NULL,
    first_name  VARCHAR NOT NULL,
    second_name VARCHAR NOT NULL,
    third_name  VARCHAR NOT NULL
);

--supper_class
CREATE TABLE supper_class_child_one
(
    id    BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name  VARCHAR NOT NULL,
    hobby VARCHAR NOT NULL
);

CREATE TABLE supper_class_child_two
(
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL,
    age  INTEGER
);

--single_table
CREATE TABLE inherit_single_table_parent
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    parent_field    VARCHAR,
    child_one_field VARCHAR,
    child_two_field VARCHAR,
    disc_col        VARCHAR
);

--table_per_class
CREATE SEQUENCE inherit_parent_seq
    START WITH 1
    INCREMENT BY 50;

CREATE TABLE inherit_parent
(
    id           BIGINT DEFAULT nextval('inherit_parent_seq') PRIMARY KEY,
    parent_field VARCHAR
);

CREATE TABLE inherit_child_one
(
    id              BIGINT DEFAULT nextval('inherit_parent_seq') PRIMARY KEY,
    parent_field    VARCHAR,
    child_one_field VARCHAR
);

CREATE TABLE inherit_child_two
(
    id              BIGINT DEFAULT nextval('inherit_parent_seq') PRIMARY KEY,
    parent_field    VARCHAR,
    child_two_field VARCHAR
);

--joined
CREATE TABLE inherit_joined_parent
(
    id           BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    parent_field VARCHAR
);


CREATE TABLE inherit_joined_child_one
(
    id              BIGINT PRIMARY KEY REFERENCES inherit_joined_parent (id),
    child_one_field VARCHAR
);

CREATE TABLE inherit_joined_child_two
(
    id              BIGINT PRIMARY KEY REFERENCES inherit_joined_parent (id),
    child_two_field VARCHAR
);


