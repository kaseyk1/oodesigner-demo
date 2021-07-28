namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.129
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 156
        'y': 113
      install_java:
        x: 354
        'y': 118
      install_tomcat:
        x: 528
        'y': 118
      install_aos_application:
        x: 730
        'y': 120
        navigate:
          531d4b46-2071-5e01-4a64-d3d08a689081:
            targetId: 635a3132-cbff-1f5a-815f-f24cb2ae50d1
            port: SUCCESS
    results:
      SUCCESS:
        635a3132-cbff-1f5a-815f-f24cb2ae50d1:
          x: 891
          'y': 118
