var process, exports;


'use strict';

console.log('Loading the function');

exports.handler = function(event, context, callback) {
  console.log('Function is running');
  callback(null, {
    statusCode: 200,
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({
      message: "Lambda invoked OK",
      event: event,
      context: context,
      env: process.env
    })
  });
};

