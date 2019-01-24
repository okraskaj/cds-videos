#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#
# This file is part of CERN Document Server.
# Copyright (C) 2016, 2017 CERN.
#
# CERN Document Server is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# CERN Document Server is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CERN Document Server; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307, USA.
#
# In applying this license, CERN does not
# waive the privileges and immunities granted to it by virtue of its status
# as an Intergovernmental Organization or submit itself to any jurisdiction.

curl -XDELETE localhost:9200/*
cds db destroy --yes-i-know
cds db init create
cds index init
cds index queue init

cds fixtures sequence-generator

# Create a test user
cds users create test@test.ch -a --password=123456
# Create an admin user
cds users create admin@test.ch -a --password=123456
cds roles create admin
cds roles add admin@test.ch admin
cds access allow deposit-admin-access role admin
cds access allow superuser-access role admin

# Create a default files location
cds files location videos /tmp/files
