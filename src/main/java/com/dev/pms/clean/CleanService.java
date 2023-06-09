package com.dev.pms.clean;

import com.dev.pms.room.BookingVO;
import com.dev.pms.room.ReservedVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
public class CleanService {

//    @Value("${file.dir.mac}")
//    private String fileDirMac;
//
//    @Value("${file.dir.windows}")
//    private String fileDirWindows;
    @Autowired
    private ServletContext servletContext;
    @Autowired
    private CleanDAO cleanDAO;
    @Autowired
    private FileManager fileManager;



    public List<CalenderVO>getCleanList(CalenderVO calenderVO)throws Exception{
        return cleanDAO.getCleanList(calenderVO);
    }

    public List<RoomCleanVO>getRoomCleanList(RoomCleanVO roomCleanVO)throws Exception{
        return  cleanDAO.getRoomCleanList(roomCleanVO);
    }

    public int insertSchedule(CalenderVO calenderVO)throws Exception{
        return cleanDAO.insertSchedule(calenderVO);
    }
    public int deleteSchedule(CalenderVO calenderVO)throws Exception{
        System.out.println(calenderVO.getScheduleNumber());
        return cleanDAO.deleteSchedule(calenderVO);
    }

    public CalenderVO getTodayClean(CalenderVO calenderVO)throws Exception{
        return cleanDAO.getTodayClean(calenderVO);
    }
    public List<ReservedVO> getRequestClean(CalenderVO calenderVO) throws Exception{
        return cleanDAO.getRequestClean(calenderVO);
    }

    public int updateCleaningInProgress(ReservedVO reservedVO) throws Exception{
        return cleanDAO.updateCleaningInProgress(reservedVO);
    }

    public int CleaningComplete(ReservedVO reservedVO) throws Exception{
        return cleanDAO.CleaningComplete(reservedVO);
    }   public int setCleanStatus(RoomCleanVO roomCleanVO)throws Exception{
        return cleanDAO.setCleanStatus(roomCleanVO);

    }

    public int saveFile(MultipartFile multipartFile) throws Exception {

        int result = 0;

        String realPath = servletContext.getRealPath("/resources/static/images/");

        realPath = fileManager.fileSave(multipartFile, realPath);

        FileVO fileVO = new FileVO();
        fileVO.setSavedName(realPath);
        fileVO.setOrgName(multipartFile.getOriginalFilename());
        result = cleanDAO.insertFile(fileVO);
        cleanDAO.updateCleanNum();
            return result;
    }

    public int setRoomClean(RoomCleanVO roomCleanVO)throws Exception{
        return cleanDAO.setRoomClean(roomCleanVO);
    }

    public Long cleanScheduleCheck(CalenderVO calenderVO) throws Exception{
        return cleanDAO.cleanScheduleCheck(calenderVO);
    }

    public int updateCheckout(BookingVO bookingVO) throws Exception {
        return cleanDAO.updateCheckout(bookingVO);
    }

    public int updateCheckoutCleaning(ReservedVO reservedVO) throws Exception{
        return cleanDAO.updateCheckoutCleaning(reservedVO);
    }

    public List<BookingVO> todayCheckIn(BookingVO bookingVO) throws Exception {

        return cleanDAO.todayCheckIn(bookingVO);
    }

    public List<BookingVO> todayCheckOut(BookingVO bookingVO) throws Exception {
        return cleanDAO.todayCheckOut(bookingVO);
    }
}
