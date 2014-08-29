file '/var/log/balanced.log' do
  mode '0777'
end

directory '/var/log/nginx' do
  mode '0777'
end

file '/var/log/nginx/access.log' do
  content <<-EOH
54.166.194.241 - USfbb1e7e82c7511e3ba46026ba7cac9da [29/Aug/2014:20:51:22 +0000] "POST /v2/identities HTTP/1.1" 201 1075 "-" "precog-client/2.42.4 balanced/1.8.7" 0.111 "guru-id=OHM3c31cb162fbe11e4a52c02a1fe53e539"
54.166.194.241 - USfbb1e7e82c7511e3ba46026ba7cac9da [29/Aug/2014:20:51:23 +0000] "POST /v2/bank_accounts HTTP/1.1" 201 1042 "-" "precog-client/2.42.4 balanced/1.8.7" 0.199 "guru-id=OHM3c913fc42fbe11e49cde02a1fe53e539"
54.166.194.241 - USfbb1e7e82c7511e3ba46026ba7cac9da [29/Aug/2014:20:51:24 +0000] "GET /v2/identities/ID3c436fba2fbe11e4b11a02ff3e25c483 HTTP/1.1" 200 371 "-" "precog-client/2.42.4 balanced/1.8.7" 0.023 "guru-id=OHM3cf9979a2fbe11e48ad106429171ffad"
54.166.194.241 - USfbb1e7e82c7511e3ba46026ba7cac9da [29/Aug/2014:20:51:24 +0000] "POST /v2/identities/ID3c436fba2fbe11e4b11a02ff3e25c483/bank_accounts HTTP/1.1" 201 1180 "-" "precog-client/2.42.4 balanced/1.8.7" 0.092 "guru-id=OHM3cf9979a2fbe11e48ad106429171ffad"
  EOH
  mode '0777'
end

%w(fluent-plugin-record-reformer).each do |gem|
  gem_package gem do
    gem_binary '/usr/lib/fluent/ruby/bin/gem'
  end
end
