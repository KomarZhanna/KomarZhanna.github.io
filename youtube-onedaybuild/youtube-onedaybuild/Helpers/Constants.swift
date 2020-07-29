//
//  ConstantsTemplate.swift
//  youtube-onedaybuild
//
//  Created by  Zhanna Komar on 7-12-20.
//  Copyright © 2020 Zhanna Komar. All rights reserved.
//

/*
 Add your own keys below and uncomment the code
 */


import Foundation


struct Constants {
    
    static var API_KEY = ""
    static var PLAYLIST_ID = "UU2D6eRvCeMtcF5OGHf1-trw"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    static var VIDEOCELL_ID = "VideoCell"
    static var YT_EMBED_URL = "https://www.youtube.com/embed/"
}

