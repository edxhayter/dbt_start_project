{#

    creation of a macro that
    1. queries the information schema of a database
    2. finds not altered within the past week
    3. generates drop statements to remove them from the database
    4. has the ability to execute those drop statements

#}

{% macro clean_stale_models(database = target.database, schema=target.schema, days=7, dry_run=TRUE) %}
    
    {% set get_drop_commands_query %}
        select 
            case
                when table_type = 'VIEW'
                    then table_type
                else
                    'TABLE'
                end as drop_type,
            'DROP ' || drop_type || ' {{ database | upper}}.' || table_schema || '.' || table_name || ';'
        from {{ database }}.information_schema.tables
        where table_schema = upper('{{ schema }}')
        and last_altered <= current_date - {{ days }}
        or left(table_name, 3) = 'leg'
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n', info=true) }}
    {% set drop_queries = run_query(get_drop_commands_query).columns[1].values() %}

    {% for query in drop_queries %}
        {% if dry_run %}
            {{ log(query, info=true) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=true) }}
            {% do run_query(query) %}
        {% endif %}
    {% endfor %}

{% endmacro %}