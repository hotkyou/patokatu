import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// 先ほど配置したサービスアカウントのキーのパスを指定する
const serviceAccount = require("../../serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.fetchCustomToken = functions
.region('asia-northeast1')
.https
.onRequest(async(request, response) => {
  const userId = request.body.data.userId;

  // userIdが不正の場合はエラーで終了
  if (typeof userId !== "string"){
    console.log("userId is not string");
    response.status(404).send({
      data: {"error": "userId is not string"},
    });
    return;
  }
  
  const customToken = await admin.auth().createCustomToken(userId);
  response.status(200).send({
    data: {"customToken": customToken},
  });
});