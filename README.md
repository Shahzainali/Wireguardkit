# WireGuard Integration Guide

Integrating WireGuard into your iOS app involves several steps, including setting up a Network Extension for the VPN tunnel and creating a bridge to WireGuard's Go implementation. Follow these steps to integrate WireGuard into your project.

## Step 1: Create a New Project

Start by creating a new project in Xcode if you haven't already done so.

## Step 2: Add Network Extension

1. Add a new target to your project by selecting **File** > **New** > **Target...**.
2. Choose the **Network Extension** target type and click **Next**.
3. Name your Network Extension, e.g., `network-extension`, and then click **Finish**.
4. When prompted to activate the scheme for the network extension, select **Cancel**.

## Step 3: External Build System Setup

1. Add another new target by selecting **File** > **New** > **Target...** again.
2. This time, select **External Build System**.
3. Name this target `WireguardGoBridge`.
4. In the **Build Tool** field, enter `$(PROJECT_DIR)/script/build_wireguard_go_bridge.sh`.

    - This script is responsible for building the WireGuard Go bridge. You can find an example of this script at `script/build_wireguard_go_bridge.sh`. Add script to your project.
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

## Conclusion

With these steps, you should now have a basic setup integrating WireGuard into your app, consisting of your main app target, the Network Extension (NE) for the VPN functionality, and the `WireguardGoBridge` for bridging WireGuard's Go code. Ensure you test the integration thoroughly to handle any potential issues related to network configurations or permissions.


# WireGuard Integration Guide

This guide aims to simplify the process of integrating WireGuard into your iOS application. By consolidating information and steps from various resources, I've attempted to make this complex procedure more approachable for developers of all skill levels.

## Acknowledgements

The creation of this guide was inspired and informed by the following resources:

- [Passepartout VPN's TunnelKit](https://github.com/passepartoutvpn/tunnelkit/blob/master/README.md)
- [Using WireGuardKit](https://github.com/roop/using-wireguardkit/blob/master/CREATING.md)

These documents provided valuable insights and instructions that helped in formulating this simplified guide.

## Simplified Integration Process

The guide provides a step-by-step approach to integrate WireGuard into your application, starting from setting up a Network Extension to adding the WireGuardKit dependency to your project. Each step is designed to be as clear and concise as possible.

## Contact

Should you encounter any issues or require further assistance, feel free to reach out:

- Email: [shahzainali93@gmail.com](mailto:shahzainali93@gmail.com)

I hope this guide facilitates a smoother integration process for you. Feedback and queries are always welcome.