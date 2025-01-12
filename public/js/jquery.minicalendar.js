/*
 * jQuery Mini Calendar
 * https://github.com/k-ishiwata/jQuery.MiniCalendar
 *
 * Copyright 2016, k.ishiwata
 * http://www.webopixel.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

;(function($) {
  $.wop = $.wop || {};
  $.wop.miniCalendar = function(targets,option){
    this.opts = $.extend({},$.wop.miniCalendar.defaults,option);
    this.ele = targets;

    // jsonファイルから読み込んだデータを入れる変数
    this.events = {};
    this.date = new Date();
    this.month = "";
    this.year = "";
    this.holiday = "";

    // jsonファイルから読み込む
    this.loadData();

    //表示する年月
    this.year = this.year || new Date().getFullYear();
    this.month = this.month || new Date().getMonth()+1;

    this.createFrame();
    this.printType(this.year, this.month);
    // 取得したイベントを表示
    this.setEvent();
  };
  $.wop.miniCalendar.prototype = {

    /**
     * 枠を作成
     */
    createFrame : function() {
      this.ele.append(`
        <div class="calendar-head">
          <div class="calendar-header-content">
            <p class="calendar-year-month"></p>
            <p class="monthly-total">今月の合計: <span id="monthlyTotal">0</span>円</p>
          </div>
        </div>
      `);

      var outText = '<table><thead><tr>';
      for (var i = 0; i < this.opts.weekType.length; i++) {
        if (i === 0) {
          outText += '<th class="calendar-sun">';
        } else if (i === this.opts.weekType.length-1) {
          outText += '<th class="calendar-sat">';
        } else {
          outText += '<th>';
        }

        outText += this.opts.weekType[i] +'</th>';
      }
      outText += '</thead><tbody></tbody></table>';
      this.ele.find('.calendar-head').after(outText);
    },

    /**
     * 日付・曜日の配置
     */
    printType : function(thisYear, thisMonth) {
      let tgtyearmonth = thisYear + '年' + thisMonth+ '月';
      $(this.ele).find('.calendar-year-month').text(tgtyearmonth);
      var thisDate = new Date(thisYear, thisMonth-1, 1);
      console.log($('.calendar-year-month').text());

      // 開始の曜日
      var startWeek = thisDate.getDay();

      var lastday = new Date(thisYear, thisMonth, 0).getDate();
      // 縦の数
      //var rowMax = Math.ceil((lastday + (startWeek+1)) / 7);
      var rowMax = Math.ceil((lastday + startWeek) / 7);

      var outText = '<tr>';
      var countDate = 1;
      // 最初の空白を出力
      for (var i = 0; i < startWeek; i++) {
        outText += '<td class="calendar-none">&nbsp;</td>';
      }
      for (var row = 0; row < rowMax; row++) {
        // 最初の行は曜日の最初から
        if (row == 0) {
          for (var col = startWeek; col < 7; col++) {
            outText += printTD(countDate, col);
            countDate++;
          }
        } else {
          // 2行目から
          outText += '<tr>';
          for (var col = 0; col < 7; col++) {
            if (lastday >= countDate) {
              outText += printTD(countDate, col);
            } else {
              outText += '<td class="calendar-none">&nbsp;</td>';
            }
            countDate++;
          }
        }
        outText += '</tr>';
      }
      $(this.ele).find('tbody').html(outText);

      function printTD(count, col) {
        var dayText = "";
        var tmpId = ' id="calender-id'+ count + '"';
        // 曜日classを割り当てる
        if (col === 0) tmpId += ' class="calendar-sun"';
        if (col === 6) tmpId += ' class="calendar-sat"';
        return '<td' + tmpId + '><i class="calendar-day-number">' + count + '</i><div class="calendar-labels">' + dayText + '</div></td>';
      }

      //今日の日付をマーク
      var toDay = new Date();
      if (thisYear === toDay.getFullYear()) {
        if (thisMonth === (toDay.getMonth()+1)) {
          var dateID = 'calender-id' + toDay.getDate();
          $(this.ele).find('#' + dateID).addClass('calendar-today');
        }
      }
    },
    /**
     * イベントの表示
     */
    setEvent : function() {
      for(var i = 0; i < this.events.length; i++) {
        var dateID = 'calender-id' + this.events[i].day;
        var getText = $('<textarea>' + this.events[i].title + '</textarea>');
        // typeがある場合classを付与
        var type = "";
        if (this.events[i].type) {
          type = '-' + this.events[i].type;
        }
        $(this.ele)
               .find('#' + dateID + ' .calendar-labels').append('<span class="calender-label' + type + '">' + getText.val() + '</span>');

      }

      // 休日
      for (var i=0; i<this.holiday.length; i++) {
        $(this.ele).find('#calender-id' + this.holiday[i]).addClass('calendar-holiday');
      }
    },

    /**
     * jsonファイルからデータを読み込む
     */
    loadData : function(targetDate = null) {
        var self = this;
        let csrfToken = $('meta[name="csrf-token"]').attr('content');

        const defaultTgtDate = targetDate || `${new Date().getFullYear()}-${(new Date().getMonth() + 1).toString().padStart(2, '0')}-01`;

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': csrfToken
            }
        });

        let url = window.routes.moneyJson;
        if (defaultTgtDate) {
            url += `?tgtdate=${defaultTgtDate}`;
        }

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            async: true,
            success: function(data) {
                console.log('API Response:', data);
                console.log('Monthly Total:', data.monthlyTotal);

                // 合計金額を更新（先に更新）
                if (data.monthlyTotal !== undefined) {
                    console.log('Updating monthly total to:', Number(data.monthlyTotal).toLocaleString());
                    $('#monthlyTotal').text(Number(data.monthlyTotal).toLocaleString());
                } else {
                    console.warn('Monthly total is undefined in response');
                }

                // MoneyControllerから取得したデータを設定
                self.events = data.event;
                self.year = data.year;
                self.month = data.month;
                self.date = new Date(data.year, data.month - 1, 1);
                self.holiday = data.holiday;

                // カレンダーを再描画
                self.printType(self.year, self.month);
                self.setEvent();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("MoneyControllerからのデータ取得に失敗:", textStatus);
                console.error("エラー詳細:", errorThrown);
            }
        });
    }
  };

  $.wop.miniCalendar.defaults = {
    weekType : ["日", "月", "火", "水", "木", "金", "土"],
    // jsonData: 'event.json'
  };
  $.fn.miniCalendar = function(option){
    option = option || {};
    var api = new $.wop.miniCalendar(this, { targetDate: null });
    return option.api ? api : this;
  };
})(jQuery);
