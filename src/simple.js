var exports, process;


'use strict';

console.log('Loading the function');

exports.handler = function (event, context, callback) {
  console.log('Function is running');
  callback(null, {
    message: "Lambda invoked OK",
    event: event,
    context: context,
    env: process.env
  });
};

