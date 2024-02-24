import got from 'got';

export const handler = async(_event, _context) => {
  const url = process.env.URL
  console.log("url -> ", url)
      
  try {
    const response = await got(url)
    return {
      statusCode: 200,
      body: JSON.parse(response.body),
    };
  } catch(err){
    console.error("Error ->", err)
    throw new Error(err)
  }
}