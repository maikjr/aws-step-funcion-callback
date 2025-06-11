const AWS = require('aws-sdk');
const stepfunctions = new AWS.StepFunctions({ endpoint: 'http://localstack:4566', region: 'us-east-1' });

exports.handler = async (event) => {
  console.log("Evento recebido:", event);

  const { taskToken, input } = event;

  console.log("armazenou o token", event);

  await stepfunctions.sendTaskSuccess({
    taskToken,
    output: JSON.stringify({
      mensagem: "Callback completo",
      inputOriginal: input
    })
  }).promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ status: "Callback enviado", input })
  };
};
