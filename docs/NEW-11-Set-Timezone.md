## 11. Set Timezone

Brad Hutchings<br/>
brad@bradhutchings.com

**The new documentation is under construction. Don't bookmark it or any pages in it yet. Links will change.**

---
### About this Step
The Completion UI indicates a build date in its Settings panel. Set your build system's time zone so that the displayed build date is local to you.

Perform this step in both your x86_64 and your aarch65 (arm64) build environments.

---
### Set Timezone

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
- **Next:** [12. Create Mmojo Share](NEW-12-Create-Mmojo-Share.md)
- **Previous:** This is the first article in this section.
- **Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)

