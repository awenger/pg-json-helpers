DROP SCHEMA IF EXISTS json_helpers CASCADE;
CREATE SCHEMA json_helpers;

/*
 Checks type of supplied json value.
 Possible Results: null, object, array, string, boolean, number, integer
 */

CREATE OR REPLACE FUNCTION json_helpers.json_type(val json) RETURNS text AS $$
DECLARE
    firstChar text;
BEGIN
    IF val IS NULL THEN
        RETURN 'null';
    END IF;

    val = btrim(val::text, E' \r\n')::json;
    firstChar := left(val::text,1);

    IF firstChar = 'n' THEN
        RETURN 'null';
    END IF;
    IF firstChar = '{' THEN
        RETURN 'object';
    END IF;
    IF firstChar = '[' THEN
        RETURN 'array';
    END IF;
    IF firstChar = '"' THEN
        RETURN 'string';
    END IF;
    IF firstChar = 't' OR firstChar = 'f' THEN
        RETURN 'boolean';
    END IF;
    IF firstChar IN ('1','2','3','4','5','6','7','8','9','0') THEN
        IF position('.' IN val::text) > 0 THEN
            RETURN 'number';
        ELSE
            RETURN 'integer';
        END IF;
    END IF;
    RAISE 'unexpected json type';
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION json_helpers.json_is_object(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'object';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_array(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'array';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_null(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'null';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_string(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'string';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_boolean(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'boolean';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_number(val json) RETURNS boolean AS $$
DECLARE
    type text;
BEGIN
    type := json_helpers.json_type(val);
    RETURN (type = 'integer' OR type = 'number');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION json_helpers.json_is_integer(val json) RETURNS boolean AS $$
BEGIN
    RETURN json_helpers.json_type(val) = 'integer';
END;
$$ LANGUAGE plpgsql;