## 11. Set Timezone

Brad Hutchings<br/>
brad@bradhutchings.com

---
### Set Timezone
The Completion UI indicates a build date in its Settings panel. Set your build system's time zone so that the displayed build date is local to you.

List available time zone names:
```
timedatectl list-timezones | column
```

Set your system's time zone:
```
sudo timedatectl set-timezone America/Los_Angeles
```

Reference: [Timedatectl can control your Linux time and time zone](https://www.networkworld.com/article/970572/using-the-timedatectl-command-to-control-your-linux-time-and-time-zone.html).

---
### Proceed
**Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
- **Next:** [12. Install Dependencies](NEW-12-Install-Dependencies.md)

