
require 'influxDB'

  database = 'wtb_automation_metrics'
  username = 'admin'
  password = 'pS5uwXL8M9djDAfa'
  permission = :write
  ## Table name
  name = 'LoadTimes'
  ## Columns
  WidgetName = "CocoRice"
  BrowserType = "Safari"

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

    influxdb = InfluxDB::Client.new(database: database,
       host: "35.235.64.255",
       use_ssl: true,
       verify_ssl: false,
       username: username,
       password: password,
       retry: 4)
  ## Writing to db
    # data = {
    #   values: { value: 0 },
    #   tags:   { SpeedTime: 600 },
    #   tags:   { WidgetName: WidgetName},
    #   tags:   {BrowserType: BrowserType}
    # }
    #
    # influxdb.write_point(name, data)
    sleep 1
  ## Query the last 5 entries
    $response_1 = influxdb.query("select * from LoadTimes limit 5")
  ## List of database
    $response_2 = "List of DBs: #{influxdb.list_databases}"
  ## Print db respones
    # print $response_1
    # print $response_2
    data = {
      values: { value: 0 },
      tags:   { TestName: $test_name},
      tags:   { FirstButtonClick: $newFirstButtonClick},
      tags:   {BrowserLoadTimeAfterClick: $newBrowserLoadTimeAfterClick}
    }

    influxdb.write_point(name, data)
