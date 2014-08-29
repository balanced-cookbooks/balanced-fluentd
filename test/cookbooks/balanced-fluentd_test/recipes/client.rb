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

file '/var/log/nginx/error.log' do
  content <<-EOH
2014/08/29 07:55:05 [error] 9401#0: *27279 connect() failed (111: Connection refused) while connecting to upstream, client: 10.3.114.50, server: , request: "GET /health HTTP/1.1", upstream: "http://0.0.0.0:6543/health", host: "10.3.108.169"
2014/08/29 11:15:05 [error] 9401#0: *27883 recv() failed (104: Connection reset by peer) while reading response header from upstream, client: 10.3.114.50, server: , request: "GET /health HTTP/1.1", upstream: "http://0.0.0.0:6543/health", host: "10.3.108.169"
2014/08/29 12:26:05 [error] 9401#0: *28034 recv() failed (104: Connection reset by peer) while reading response header from upstream, client: 10.3.114.50, server: , request: "GET /health HTTP/1.1", upstream: "http://0.0.0.0:6543/health", host: "10.3.108.169"
2014/08/29 16:23:35 [error] 9401#0: *28789 connect() failed (111: Connection refused) while connecting to upstream, client: 10.3.114.50, server: , request: "GET /health HTTP/1.1", upstream: "http://0.0.0.0:6543/health", host: "10.3.108.169"
  EOH
  mode '0777'
end

%w(fluent-plugin-record-reformer).each do |gem|
  gem_package gem do
    gem_binary '/usr/lib/fluent/ruby/bin/gem'
  end
end
