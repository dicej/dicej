"use strict";

let http = require("http");
let assert = require("assert");

let blockSize = 16;
let urlPrefix = "http://crypto-class.appspot.com/po?er=";
let c = new Buffer("f20bdba6ff29eed7b046d1df9fb7000058b1ffb4210a580f748b4ac714c001bd4a61044426fb515dad3f21f18aa577c0bdf302936266926ff37dbf7035d5eeb4", "hex");

function xor(a, b) {
    let length = a.length > b.length ? b.length : a.length;
    let result = new Buffer(length);
    for (let i = 0; i < length; ++i) {
        result[i] = a[i] ^ b[i];
    }
    return result;
}

function query(guess, callback) {
    let index = c.length - blockSize - guess.length;
    let blockNumber = Math.floor(index / blockSize);
    let attempt = new Buffer((blockNumber + 2) * blockSize);
    assert(attempt.length <= c.length);
    
    let padding = ((blockNumber + 1) * blockSize) - index;
    for (let i = 0; i < index; ++i) {
        attempt[i] = c[i];
    }
    for (let i = 0; i < padding; ++i) {
        let j = index + i;
        attempt[j] = c[j] ^ guess[i] ^ padding;
    }
    for (let i = 0; i < blockSize; ++i) {
        let j = index + padding + i;
        attempt[j] = c[j];
    }

    //console.log("originl " + c.toString("hex"));
    console.log("attempt " + xor(attempt, c).toString("hex"));
    http.get(urlPrefix + attempt.toString("hex"), function(response) {
        switch (response.statusCode) {
        case 403:
            callback(false);
            break;

        case 404:
        case 200:            
            callback(true);
            break;

        default:
            console.log("unexpected response status code: " + response.statusCode);
        }
    }).on("error", function(e) {
        console.log("error: " + e.message);
    });
}

function prepend(a, b) {
    let result = new Buffer(b.length + 1);
    result[0] = a;
    b.copy(result, 1);
    return result;
}

function queryAll(guess) {
    query(guess, function(success) {
        if (success) {
            if (guess.length == c.length - 16) {
                console.log("plaintext is " + guess.toString("hex"));
            } else {
                console.log("plaintext so far is " + guess.toString("hex"));
                queryAll(prepend(0, guess));
            }
        } else {
            let n = guess[0];
            if (n == 255) {
                console.log("no guesses worked!");
            } else {
                guess[0] = n + 1;
                queryAll(guess);
            }
        }
    });
}

//queryAll(new Buffer("546865204d6167696320576f726473206172652053717565616d697368204f7337730fdea4b4eae06667726469ad9afe", "hex"));
queryAll(new Buffer("0009", "hex"));
