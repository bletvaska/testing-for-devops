#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'

DB_PATH="data/chinook.sqlite"

# source "sqlquery_sqlite.sh"


sql_query() {
    local query="${1}"

    sqlite3 "${DB_PATH}" "${query}"
}


@test "when imported expect 5 media types" {
    # Arrange
    query="select count(*) from mediatype"
    expected=5

    # Act
    run sql_query "${query}"

    # Assert
    assert [[ $output == $expected ]]
}


@test "when imported, then number of tracks is 3503" {
    # Arrange
    query="select count(*) from track"
    expected=3503

    # Act
    run sql_query "${query}"

    # Assert
    assert [[ $output == $expected ]]
}


@test "when imported, then number of albums is 347" {
    # Arrange
    query="select count(*) from album"
    expected=347

    # Act
    run sql_query "${query}"

    # Assert
    assert [[ $output == $expected ]]
}


@test "when imported, then number of customers is 59" {
    #Arrange
    query="select count(*) from customer"
    expected=59

    # Act
    run sql_query "${query}"

    # Assert
    assert [[ $output == $expected ]]
}


@test "when imported, then no track has negative unit price" {
    #Arrange
    query="select unitprice from track where unitprice < 0"

    # Act
    run sql_query "${query}"

    # Assert
    assert_success
}


@test "when imported, then no invoice line has negative unit price" {
    #Arrange
    query="select unitprice from invoiceline where unitprice < 0"

    # Act
    run sql_query "${query}"

    # Assert
    assert_success
}


@test "when imported, then we have specific list of countries" {
    # Arrange
    query="select count(*) from customer where Country not in ('Brazil', 'Denmark', 'Ireland', 'Poland', 'United Kingdom', 'Chile', 'Norway', 'Austria', 'Germany', 'USA', 'France', 'Finland', 'Spain', 'India', 'Hungary', 'Australia', 'Canada', 'Belgium', 'Czech Republic', 'Sweden', 'Argentina', 'Portugal', 'Italy', 'Netherlands')"
    expected=0

    # Act
    run sql_query "$query"

    # Assert
    assert_output "$expected"
}

