"use strict";

var crypto = require("crypto");
var fs = require('fs');

var BlockSize = 1024;

function ceilingDivide(n, d) {
    return Math.ceil(n / d);
}

function hashStep(fd, fileLength, blockIndex, previousHash, callback) {
    console.log("hash step " + blockIndex);
    let blockPosition = blockIndex * BlockSize;
    let blockLength = fileLength - blockPosition;
    if (blockLength > BlockSize) {
        blockLength = BlockSize;
    }
    fs.read(fd, new Buffer(blockLength), 0, blockLength, blockPosition, function(err, count, buffer) {
        if (err) {
            callback(err, null);
            return;
        }
        if (count != blockLength) {
            callback(new Error("read error"), null);
            return;
        }
        let hash = crypto.createHash("sha256");
        hash.update(buffer);
        if (previousHash) {
            hash.update(previousHash);
        }
        let h = hash.digest();
        if (blockPosition == 0) {
            callback(null, h);
            return;
        } else {
            hashStep(fd, fileLength, blockIndex - 1, h, callback);
        }
    });
}

function hash(fd, fileLength, callback) {
    hashStep(fd, fileLength, ceilingDivide(fileLength, BlockSize) - 1, null, callback);
}

fs.open(process.argv[2], "r", function(err, fd) {
    if (! err) {
        fs.fstat(fd, function(err, stats) {
            if (err) {
                fs.close(fd);
            } else {
                hash(fd, stats.size, function(err, hash) {
                    console.log("hash is " + hash.toString("hex"));
                    fs.close(fd);
                });
            }
        });
    }
});
