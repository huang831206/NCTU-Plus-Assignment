# NCTU Plus 工程組測試作業
- 此為NCTU plus 2016年度徵才用的測試用作業
- 基本上為一個公佈欄系統，加上一個即時聊天室
- 測試用的部署(使用Heroku)
  - [Heroku連結](https://nctu-plus-test.herokuapp.com/)

# 系統需求
- Ruby 2.3
- Rails 5.0.0.rc1 , < 5.1
  - 不可在Rails 4或更舊的系統下運作
- Redis Server


# 公佈欄系統
- 基本CRUD
- 支援排程公告，可指定公告開始時間與結束時間

# 即時聊天室
- 使用ActionCable + WebSocket
- 就是一個簡單的即時聊天室
- 與公告系統連結：新增、更新、移除公告時也會傳訊息到聊天室



