#!/bin/bash
# This file is intended to be run through systemd, since systemd has
# environment variables set that restic needs.
restic check
