
SELECT *, actual = expected as passed FROM (

SELECT 'basic obj check' as test, json_helpers.json_type('{}'::json) as actual, 'object' as expected
UNION ALL
SELECT 'array check 1' as test, json_helpers.json_type('[]'::json) as actual, 'array' as expected
UNION ALL
SELECT 'array check 2' as test, json_helpers.json_type('[1,{"a":1.3},"test"]'::json) as actual, 'array' as expected
UNION ALL
SELECT 'boolean true check' as test, json_helpers.json_type('true'::json) as actual, 'boolean' as expected
UNION ALL
SELECT 'boolean false check' as test, json_helpers.json_type('false'::json) as actual, 'boolean' as expected
UNION ALL
SELECT 'basic null check' as test, json_helpers.json_type('null'::json) as actual, 'null' as expected
UNION ALL
SELECT 'null with leading blanks' as test, json_helpers.json_type('    null'::json) as actual, 'null' as expected
UNION ALL
SELECT 'null with leading newline' as test, json_helpers.json_type(E'\n\r\nnull'::json) as actual, 'null' as expected
UNION ALL
SELECT 'null with leading newline + blanks' as test, json_helpers.json_type(E'  \n   \n\r  \n \r\nnull'::json) as actual, 'null' as expected
UNION ALL
SELECT 'integer check' as test, json_helpers.json_type('0'::json) as actual, 'integer' as expected
UNION ALL
SELECT 'number check' as test, json_helpers.json_type('0.1'::json) as actual, 'number' as expected
UNION ALL
SELECT 'string check' as test, json_helpers.json_type('"lore ipsum"'::json) as actual, 'string' as expected
UNION ALL
SELECT 'selection test text' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'string') as actual, 'string' as expected
UNION ALL
SELECT 'selection test boolean' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'boolean') as actual, 'boolean' as expected
UNION ALL
SELECT 'selection test integer' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'int') as actual, 'integer' as expected
UNION ALL
SELECT 'selection test number' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'number') as actual, 'number' as expected
UNION ALL
SELECT 'selection test array' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'array') as actual, 'array' as expected
UNION ALL
SELECT 'selection test null' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'null') as actual, 'null' as expected
UNION ALL
SELECT 'selection test null non existing' as test, json_helpers.json_type('{"string":"lore ipsum","boolean":true,"int":1,"number":1.2,"array":[],"null":null}'::json->'notexists') as actual, 'null' as expected

)tmp ORDER BY actual = expected;


