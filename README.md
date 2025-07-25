# WireGuard Integration Guide

This guide aims to simplify the process of integrating WireGuard into your iOS application.  I've tried to make this complex procedure easy.

# Xcode 15

## Step 1: Create a New Project

Start by creating a new project in Xcode if you haven't already done so.

## Step 2: Add Network Extension

1. Add a new target to your project by selecting **File** > **New** > **Target...**.
2. Choose the **Network Extension** target type and click **Next**.
3. Name your Network Extension, e.g., `network-extension`, and then click **Finish**.
4. When prompted to activate the scheme for the network extension, select **Cancel**.

## Step 3: External Build System Setup

1. Add another new target by selecting **File** > **New** > **Target...** again. We are using this external build system for building wireguard.
2. This time, select **External Build System**.
3. Name this target `WireguardGoBridge`.
4. In the **Build Tool** field, enter `$(PROJECT_DIR)/script/build_wireguard_go_bridge.sh`.

    - This script is responsible for building the WireGuard. You can find the script at `script/build_wireguard_go_bridge.sh`. Add script to your project.
    - Modify the Go path in the script at line 38 as necessary, according to your setup. Refer to [this Stack Overflow answer](https://stackoverflow.com/a/64212121) for guidance.

## Step 4: Add WireGuardKit Dependency

1. To your project, add the WireGuardKit dependency by navigating to **Project** > **Package Dependencies**, then click the **+** button.
2. Enter the URL `https://git.zx2c4.com/wireguard-apple` and select the exact version `1.0.15-26`.
3. When prompted, select the `network-extension` target for the package.

## Step 5: Configure Targets

1. For your Network Extension (NE) target:
    - Go to **Build Phases** > **Target Dependencies** and add `WireguardGoBridge` as a dependency.
    - Under **Build Phases** > **Link Binary with Libraries**, ensure `WireguardKit` and `NetworkExtension.framework` are available.

2. Ensure `WireguardKit` targets the `network-extension` in its build phases.

## Step 6: Add Configuration Extensions

In your Network Extension target, add `TunnelConfiguration+wgQuickConfig` and `String+ArrayConversion` extensions. These will help in configuring the tunnel and handling array conversions, respectively.

Dont forget to change identifier [here](https://github.com/Shahzainali/Wireguardkit/blob/e42f0fcf9b9f169575b48bfa9a2671db686676d6/Wireguardkit/WireguardkitApp.swift#L38)
Also edit the wireguard config [here](https://github.com/Shahzainali/Wireguardkit/blob/e42f0fcf9b9f169575b48bfa9a2671db686676d6/Wireguardkit/WireguardkitApp.swift#L44)

### Also please note you will need real device for testing, Network extensions don't work on simulators.

# Xcode 16

## Step 1: Same as above
## Step 2: Same as above
## Step 3: Skip this one
## Step 4: Add WireGuardKit Dependency (unofficial source with fixed issue)

1. To your project, add the WireGuardKit dependency by navigating to **Project** > **Package Dependencies**, then click the **+** button.
2. Enter the URL `https://github.com/ut360e/wireguard-apple.git` and add.
3. When prompted, select the `network-extension` target for the package.

## Step 5: Skip this one
## Step 6: Same as above
## Step 7: Add prebuilt wireguard lib.

1. In the Project Navigator, go to the NetworkExtension target → General → Frameworks & libraries.

2. Add libwg-go.a (included in the repository).

⚠️ This xcode 16 solution works perfectly for iOS, but will most likely not work for macOS, since libwg-go.a is a prebuilt WireGuard library specifically for iPhoneOS.

## ☕ Support My Work

If you find this project helpful, consider supporting me:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-%23FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/shahzainali)

Thank you for your support! 🙏

## Acknowledgements

Taken help from:

- [Passepartout VPN's TunnelKit](https://github.com/passepartoutvpn/tunnelkit/blob/master/README.md)
- [Using WireGuardKit](https://github.com/roop/using-wireguardkit/blob/master/CREATING.md)

## Contact

Feel free to open any issue or contact me if you face any issues.

| **Platform**   | **Link** |
|----------------|------------------------------------------------|
| **Email**      | [shahzainali93@gmail.com](mailto:shahzainali93@gmail.com) |
| **LinkedIn**   | [LinkedIn Profile](https://www.linkedin.com/in/shahzainali/) |
| **StackOverflow** | [StackOverflow Profile](https://stackoverflow.com/users/5154783/shahzain-ali) |



I hope this guide facilitates a smoother integration process for you. Feedback and queries are always welcome.
