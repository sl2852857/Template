package com.hullsoft.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 文件上传操作工具类
 * @author Administrator
 *
 */
public class FileOperateUtils {
	private static final Logger log = LoggerFactory.getLogger(FileOperateUtils.class);
	
	/**
	 * 
	 * @param request
	 * @param localPath 上传文件到本地的路径;
	 * @param renamePrefix 重命名文件用的前缀（renamePrefix +　原文件名）;
	 * @return　返回结果：List<Map>集合，一个map对应一个文件上传的记录;
	 * 	map.get(useTime)取到耗时;
	 * 	map.get(filePath)取到上传文件路径;
	 * 	map.get(filename)取到上传文件的原文件名;
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public static List<Map<String, String>> upload(HttpServletRequest request, String localPath) {  
		log.info("开始上传文件");
		String rootPath = request.getSession().getServletContext().getRealPath("/");//获取web项目的路径
		//存放上传结果
		List<Map<String, String>> results = new ArrayList<Map<String,String>>();
		//创建一个通用的多部分解析器  
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断 request 是否有文件上传,即多部分请求  
        int count = 0;
        if(multipartResolver.isMultipart(request)){  
            //转换成多部分request    
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;  
            //取得request中的所有文件名  
            Iterator<String> iter = multiRequest.getFileNames(); 
            //存放上传文件路径和上传耗时
        	Map<String, String> result = null;
            while(iter.hasNext()){  
            	
                //long pre = System.currentTimeMillis();  
                //取得上传文件  
                MultipartFile file = multiRequest.getFile(iter.next());
                if(file != null){
                    //取得当前上传文件的文件名称  
                    String myFileName = file.getOriginalFilename();  
                    log.info("上传文件：["+myFileName+"]");
                    //如果名称不为"",说明该文件存在，否则说明该文件不存在  
                    if(myFileName.trim()!=""){  
                    	//存放上传文件路径和上传耗时
                    	result = new HashMap<String, String>();
                    	//记录上传过程起始时的时间，用来计算上传时间  
                    	long preTime = System.currentTimeMillis();
                        //重命名上传后的文件名(当前时间	+	随机数	+	文件后缀名)
                        String fileName = DateUtils.now("yyyyMMddHHmmss") + MathUtils.getRandomByLength(5) + myFileName.substring(myFileName.lastIndexOf(".")+1);  
                        log.info("上传文件重命名为：["+fileName+"]");
                        //定义上传路径  
                        String path = rootPath + localPath + File.separator + fileName;
                        log.info("上传路径为："+path);
                        File localFile = new File(path);  
                        //如果路径不存在则建立
                        if(!new File(localPath).exists()){
                        	log.info("路径不存在，创建路径["+ rootPath + localPath + "]");
                        	localFile.mkdirs();
                        }
                        //上传失败不计入
                        try {
							file.transferTo(localFile);
							//上传完成记录数+1
							count++;
							long useTime = System.currentTimeMillis() - preTime;
							result.put("filename", file.getOriginalFilename());
							result.put("filePath", localPath + File.separator + fileName);
							result.put("useTime", String.valueOf(useTime)+"ms");
							results.add(result);
						} catch (IllegalStateException e) {
							log.error("系统异常(非法语句异常)", e);
						} catch (IOException e) {
							log.error("系统异常(输入输出异常)", e);
						}
                        result = null;
                    }  
                }  
            } 
        }else{
        	log.info("无文件上传");
        }
        log.info("文件上传完成! 共上传 [" + count + "] 个文件");
        return results;  
    }
	
	public static void download(String filePath, HttpServletRequest request,
            HttpServletResponse response) {
		String filename = filePath.substring(filePath.lastIndexOf(File.separator)+1);
		log.info("开始下载文件 [ " + filename + " ]");
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName="
                + filename);
        
        InputStream inputStream = null;
        OutputStream os = null;
        try {
        	inputStream = new FileInputStream(new File(filePath));
            os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
            os.flush();
        } catch (FileNotFoundException e) {
        	log.error("系统异常(FileNotFoundException)", e);
        } catch (IOException e) {
            log.error("系统异常(IOException)", e);
        } finally {
        	// 这里主要关闭。
        	try {
				os.close();
				inputStream.close();
			} catch (IOException e) {
				log.error("输入输出流关闭异常", e);
			}
        }
        log.info("下载文件结束");
    }
	
	
	/**
	 * 删除文件
	 * @param filePath
	 */
	public static boolean deleteFile(String filePath){
		boolean flag = false;  
	    File file = new File(filePath);  
	    // 判断目录或文件是否存在  
	    if (file.isFile()&&file.exists()) {
	    	file.delete();
	    	log.info("文件删除成功，路径："+filePath);
	    	flag = true;
	    }
	    return flag;
	}
}
