"use strict";

var crypto = require("crypto");
var assert = require("assert");

function increment(buffer) {
    let result = new Buffer(buffer.length);
    let increment = 1;
    for (let i = buffer.length - 1; i >= 0; --i) {
        let n = buffer[i] + increment;
        if (n > 0xFF) {
            result[i] = n - 0x100;
            increment = 1;
        } else {
            result[i] = n;
            increment = 0;
        }
    }
    return result;
}

function unhex(s) {
    return new Buffer(s, "hex");
}

function xor(a, b) {
    let length = a.length > b.length ? b.length : a.length;
    let result = new Buffer(length);
    for (let i = 0; i < length; ++i) {
        result[i] = a[i] ^ b[i];
    }
    return result;
}

function ascii(buffer) {
    return buffer.toString("ascii");
}

function uncbc(key, iv, input) {
    let encrypted = unhex(input);
    let previous = unhex(iv);
    let result = "";
    
    for (let i = 0; i < encrypted.length; i += 16) {
        let length = encrypted.length - i;
        let padding = false;
        if (length > 16) {
            length = 16;
        } else {
            assert(length == 16);
            padding = true;
        }
        let block = encrypted.slice(i, i + length);
        let decipher = crypto.createDecipheriv("aes-128-ecb", unhex(key), "");
        decipher.setAutoPadding(false);
        let x = decipher.update(block);
        let decrypted = xor(x, previous);
        let decryptedLength = 16;
        if (padding) {
            decryptedLength = 16 - decrypted[15];
            assert(decryptedLength >= 0);
        }
        result += ascii(decrypted.slice(0, decryptedLength));
        previous = block;
    }
    
    console.log(result);
}

function unctr(key, iv, input) {
    { let decipher = crypto.createDecipheriv("aes-128-ctr", unhex(key), unhex(iv));
      console.log(decipher.update(unhex(input)).toString("ascii"));
      console.log(decipher.final().toString("ascii"));
    }

    let encrypted = unhex(input);
    let counter = unhex(iv);
    let result = "";
    
    for (let i = 0; i < encrypted.length; i += 16) {
        let length = encrypted.length - i;
        if (length > 16) {
            length = 16;
        }
        let cipher = crypto.createCipheriv("aes-128-ecb", unhex(key), "");
        cipher.setAutoPadding(false);
        let decrypted = xor(cipher.update(counter), encrypted.slice(i, i + length));
        console.log(counter.toString("hex") + " increments to " + increment(counter).toString("hex"));
        counter = increment(counter);
        result += ascii(decrypted);
    }
    
    console.log(result);
}

uncbc("140b41b22a29beb4061bda66b6747e14",
      "4ca00ff4c898d61e1edbf1800618fb28",
      "28a226d160dad07883d04e008a7897ee2e4b7465d5290d0c0e6c6822236e1daafb94ffe0c5da05d9476be028ad7c1d81");

uncbc("140b41b22a29beb4061bda66b6747e14",
      "5b68629feb8606f9a6667670b75b38a5",
      "b4832d0f26e1ab7da33249de7d4afc48e713ac646ace36e872ad5fb8a512428a6e21364b0c374df45503473c5242a253");

unctr("36f18357be4dbd77f050515c73fcf9f2",
      "69dda8455c7dd4254bf353b773304eec",
      "0ec7702330098ce7f7520d1cbbb20fc388d1b0adb5054dbd7370849dbf0b88d393f252e764f1f5f7ad97ef79d59ce29f5f51eeca32eabedd9afa9329");

unctr("36f18357be4dbd77f050515c73fcf9f2",
      "770b80259ec33beb2561358a9f2dc617",
      "e46218c0a53cbeca695ae45faa8952aa0e311bde9d4e01726d3184c34451");
