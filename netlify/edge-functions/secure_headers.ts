export default async (request: Request, context: any) => {
  const response = await context.next();
  
  // 🛡️ حماية متطرفة: السماح بفتح هذا التطبيق فقط داخل الراوتر الأمني الخاص بك (منع الاختطاف)
  const allowedOrigins = "https://my-video-project-c6696.web.app https://my-video-project-c6696.firebaseapp.com";
  response.headers.set("Content-Security-Policy", `frame-ancestors 'self' ${allowedOrigins};`);
  
  response.headers.set("X-Content-Type-Options", "nosniff");
  
  // 🚀 ترويسات ضرورية لتشغيل محرك WebAssembly (Wasm) بأقصى أداء ممكن
  response.headers.set("Cross-Origin-Opener-Policy", "same-origin");
  // response.headers.set("Cross-Origin-Embedder-Policy", "credentialless"); // تم تعطيلها لتسريع الوسائط الخارجية
  
  return response;
};
