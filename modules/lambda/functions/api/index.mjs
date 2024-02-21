import got from 'got';

export const handler = async(event, context) => {
  console.log("Event -> ", event)
  console.log("Context -> ", context)
    
  try {
    const response = await got('https://labs.bible.org/api/?passage=random&type=json')
    return {
      statusCode: 200,
      body: JSON.parse(response.body),
    };
  }catch(err){
    console.error("Error ->", err)
    throw new Error(err)
  }
}