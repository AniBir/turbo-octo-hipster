# we are the cool kids so we need json here
require 'json'
require 'digest/md5'

newFileHashes = {}

Dir.glob('/Users/livio/Desktop/FHNW/**/*.*').each do |file|
	if File.file?(file)
  		newFileHashes[file] = Digest::MD5.hexdigest(File.read(file))
  	end
end

newFileHashesJSON = File.open("/Users/livio/Desktop/hashes.json","w:UTF-8")
newFileHashesJSON.write(JSON.pretty_generate(newFileHashes))
newFileHashesJSON.close

oldFileHashes = JSON.parse(File.open('/Users/livio/Desktop/old_hashes.json', 'r:UTF-8').read)

oldFileHashes.merge(newFileHashes) { |key, oldval, newval| 
	if not oldval == newval
		puts key + ' changed locally since last fetch from AD'
	end
}