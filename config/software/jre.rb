#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "jre"
default_version "7u51-b13"

dependency "rsync"

whitelist_file "jre/bin/javaws"
whitelist_file "jre/bin/policytool"
whitelist_file "jre/lib"
whitelist_file "jre/plugin"

if OHAI.kernel['machine'] =~ /x86_64/
  # TODO: download x86 version on x86 machines
  source :url => "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jre-7u51-linux-x64.tar.gz",
         :md5 => "1f6a93cc5ef5f66bb01bc39fd731cd9f",
         :cookie => 'oraclelicensejre-7u51-oth-JPR=accept-securebackup-cookie;gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html',
         :warning => "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
else
  source :url => "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jre-7u51-linux-i586.tar.gz",
         :md5 => "f133f125ca93acef3f70d1912cc2f4b0",
         :cookie => 'oraclelicensejre-7u51-oth-JPR=accept-securebackup-cookie;gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html',
         :warning => "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
end

relative_path "jre1.7.0_51"

jre_dir = "#{install_dir}/embedded/jre"

build do
  command "mkdir -p #{jre_dir}"
  command "#{install_dir}/embedded/bin/rsync -a . #{jre_dir}/"
end
