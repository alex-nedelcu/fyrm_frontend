# ```Find your rentmate!``` frontend

### Run application on physical iOS device
Follow [this tutorial](https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8)

### Google Maps integration
- Credentials [here](https://console.cloud.google.com/apis/credentials?project=seventh-capsule-374707)

### Troubleshooting
  - **map is greyed out ->** check whether the IP of the current device is still listed in the allowed IPs of the API key
  - **connection refused when running application on physical device ->**
    - check whether `externalBaseUrl` is still the one provided
    - in order to find to current external IP address of the device run:
    ```shell
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -1
    ```

#### TODO
- provide a link to supported domains page
- add to sign up form:
  - date picker for `birthdate`
  - `gender` picker
  - `first name` text input
  - `last name` text input