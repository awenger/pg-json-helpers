pg-json-helpers
===============

PostgreSQL Json Helpers

## Install

Execute json_helpers.sql in the Database 

## Test

Execute test.sql in the Database

## Basic Usage

```
SELECT json_helpers.json_type('0.1'::json); // 'number'
SELECT json_helpers.json_type('[0.1]'::json);  // 'array'
...

SELECT json_helpers.json_is_number('0.1'::json); // true
SELECT json_helpers.json_is_array('{"a":0.1}'::json); // false

....
```

## Possible types

* null
* object
* array
* string
* boolean
* number
** integer

## Usage for Table Constraints
```
CREATE TABLE test (
    data json,
    CONSTRAINT validate_id  CHECK (json_helpers.json_is_integer(data->'id') AND (data->>'id')::integer > 0),
    CONSTRAINT validate_name CHECK (json_helpers.json_is_string(data->'name') AND length(data->>'name') >= 3),
    CONSTRAINT validate_optional_boolean CHECK (json_helpers.json_is_null(data->'optional') OR json_helpers.json_is_boolean(data->'optional'))
);
CREATE UNIQUE INDEX test_id_idx ON test ((data->>'id'));

INSERT INTO test VALUES('{}'::json); // error (format)
INSERT INTO test VALUES('{"id":1, "name":"max"}'::json); // ok
INSERT INTO test VALUES('{"id":2, "name":"max", "optional":1}'::json); // error (format)
INSERT INTO test VALUES('{"id":3, "name":"max", "optional":true}'::json); // ok
INSERT INTO test VALUES('{"id":3, "name":"max", "optional":true}'::json); // error duplicate id
```