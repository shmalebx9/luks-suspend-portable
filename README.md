# The Problem

When you suspend your computer, your LUKS key is saved in ram.
Most users want their data to be encrypted when the lid is closed, not just when it's off.

Lots of scripts like [c6fc's](https://github.com/c6fc/ubuntu-lukssuspend) allow you to encrypt your data on lid close.
Afaik, all of these solutions are distro-specific, or at least require systemD.

The solution here is based on creating a simple, self-contained, Alpine linux system in the /boot partition.
When you suspend with the script provided, you'll be running off that one portable system.

# Instructions

You must have an unencrypted /boot partition, which is generally the case.

**Step 1:**
Download the alpine archive and extract it to `/boot/suspend`

**Step 2:**
Move the zzzluks to somewhere in your $PATH and make it executable.
