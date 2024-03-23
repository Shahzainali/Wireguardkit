#!perl -w

use File::Basename;
use File::chdir;

# Find the dir where WireGuardKitGo is checked out by Xcode
my $buildParentDir = findBuildParentDir();
my $wireGuardGoDir = findWireGuardGoCheckoutDir($buildParentDir);

# Make sure Go is in the PATH, assuming it's installed
# through Homebrew.
$ENV{PATH} = "$ENV{PATH}:/usr/local/bin:/opt/homebrew/bin";

# cd to the WireGuardKitGo dir and call make
print("Invoking make in '$wireGuardGoDir'\n");
chdir($wireGuardGoDir);
system("/usr/bin/make");

sub findBuildParentDir {
    # Equivalent of using "${BUILD_DIR%Build/*}" in the directory
    # field of an External Build System configuration in Xcode
    my $buildDir = $ENV{BUILD_DIR};
    $buildDir or die "BUILD_DIR environment variable is not set\n";
    my $parentDir = $buildDir;
    while ($parentDir && $parentDir ne "/") {
        my $basename = basename($parentDir);
        $parentDir = dirname($parentDir);
	if ($basename eq "Build") {
	    return $parentDir;
	}
    }
    die "Cannot find directory ancestor named 'Build' in the BUILD_DIR: ${buildDir}\n"
}

sub findWireGuardGoCheckoutDir {
    my ($buildParentDir) = @_;
    my @candidates = (
        "${buildParentDir}/SourcePackages/checkouts/Sources/WireGuardKitGo",
        "${buildParentDir}/SourcePackages/checkouts/wireguard-apple/Sources/WireGuardKitGo"
    );
    for my $candidate (@candidates) {
        if (-d $candidate) {
            return $candidate;
        }
    }
    die "Cannot find directory where WireGuardKitGo is checked out by Xcode (Looking under $buildParentDir)\n";
}