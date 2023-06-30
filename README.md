# ```Find your rentmate!``` frontend

### Run application on physical iOS device
Follow [this tutorial](https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8)

### Google Maps integration
- Credentials [here](https://console.cloud.google.com/apis/credentials?project=seventh-capsule-374707)

### Troubleshooting
  - **map is greyed out ->** check whether the IP of the current device is still listed in the allowed IPs of the API key
  - **connection refused when running application on physical device ->**
    - check whether `externalBaseUrl` and `url` inside `StompConfig.SockJS` are still the ones provided
    - in order to find to current external IP address of the device run:
    ```shell
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -1
    ```

### Supported universities
- Babes-Bolyai University : `@stud.ubbcluj.ro`
- University of Bucharest : `@s.unibuc.ro`
- Iuliu Hatieganu University of Medicine and Pharmacy : `@elearn.umf.ro`
- Politehnica University of Bucharest - Transportations : `@stud.trans.ro`
- Politehnica University of Bucharest - Industrial Engineering and Robotics : `@stud.fiir.ro`
- Politehnica University of Bucharest - Electronics, Telecommunications and IT : `@stud.etti.ro` 
