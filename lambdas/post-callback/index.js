exports.handler = async (event) => {
 console.log("Lambda pós-callback recebeu:", JSON.stringify(event, null, 2));

  // Acessar input original
  const inputOriginal = event.inputOriginal;

  console.log("Input original recebido:", inputOriginal);

  return {
    statusCode: 200,
    body: JSON.stringify({ status: "Pós-processamento concluído", inputOriginal })
  };
};
