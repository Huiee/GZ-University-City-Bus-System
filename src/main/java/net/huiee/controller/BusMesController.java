package net.huiee.controller;

import net.huiee.service.BusMesService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class BusMesController {
    @Resource
    BusMesService busMesService;
}
