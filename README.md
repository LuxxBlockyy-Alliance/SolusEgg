# SolusEgg

SolusEgg includes Java 8, 17, 21 and 25. On startup it automatically selects a
runtime based on the saved Minecraft version:

| Minecraft version | Java version |
| --- | --- |
| up to 1.16.x | 8 |
| 1.17.x to 1.20.4 | 17 |
| 1.20.5 to 1.21.x | 21 |
| 26.x and newer | 25 |

Set the `JAVA_VERSION` environment variable to `8`, `17`, `21`, or `25` to
override automatic selection, for example for a mod loader with different
requirements. Its default value is `auto`.
 
