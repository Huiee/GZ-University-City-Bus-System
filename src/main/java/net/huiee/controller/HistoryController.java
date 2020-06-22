package net.huiee.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
import net.huiee.entity.History;
import net.huiee.service.HistoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HistoryController {
    @Resource
    HistoryService historyService;

    @RequestMapping("showHistory")
    public String showHistory(Model model, HttpSession session){
        String user_id = (String) session.getAttribute("user_id");
        List<History> histories = historyService.searchHistory(user_id);
        model.addAttribute("history",histories);
        return "history";
    }

    @RequestMapping("searchHistoryByType")
    public String searchHistoryByType(Model model, HttpSession session,String history_type){
        String user_id = (String) session.getAttribute("user_id");
        List<History> histories = historyService.searchHistoryByType(user_id,history_type);
        model.addAttribute("history",histories);
        return "history";
    }

    @RequestMapping("deleteHistory")
    public String deleteHistory(Model modle,HttpSession session,String history_time){
        String user_id = (String) session.getAttribute("user_id");
        historyService.deleteHistory(user_id,history_time);
        return "showHistory";
    }
}
