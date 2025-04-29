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
        <style>
          @media (max-width: 768px) {
            .item-totals {
              grid-template-columns: 1fr !important;
              gap: 8px !important;
            }
            .total-item {
              padding: 15px !important;
            }
            .total-item > div:first-child {
              font-size: 1em !important;
            }
            .total-item > div:last-child {
              font-size: 1.2em !important;
              margin-top: 5px !important;
            }
            .calendar-year-month {
              font-size: 20px !important;
            }
            .monthly-total {
              font-size: 18px !important;
            }
          }
        </style>
        <div class="calendar-head">
          <div class="calendar-header-content">
            <p class="calendar-year-month" style="text-align: center; font-size: 24px; margin-bottom: 10px;"></p>
            <p class="monthly-total" style="text-align: center; font-size: 20px; margin-bottom: 20px; color: #e74c3c;">今月の合計: <span id="monthlyTotal">0</span>円</p>
            <div class="totals-container" style="
              background: #f8f9fa;
              border-radius: 8px;
              padding: 15px;
              margin: 0 auto 20px;
              width: 100%;
              box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
            ">
              <div class="item-totals" style="
                display: grid;
                grid-template-columns: repeat(6, 1fr);
                gap: 10px;
                width: 100%;
              ">
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">食費</div>
                  <div><span id="itemTotal1" style="font-weight: bold;">0</span>円</div>
                </div>
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">日用品</div>
                  <div><span id="itemTotal2" style="font-weight: bold;">0</span>円</div>
                </div>
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">衣服</div>
                  <div><span id="itemTotal3" style="font-weight: bold;">0</span>円</div>
                </div>
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">交通費</div>
                  <div><span id="itemTotal4" style="font-weight: bold;">0</span>円</div>
                </div>
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">その他</div>
                  <div><span id="itemTotal5" style="font-weight: bold;">0</span>円</div>
                </div>
                <div class="total-item" style="
                  background: white;
                  padding: 10px 5px;
                  border-radius: 6px;
                  text-align: center;
                  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                  display: flex;
                  flex-direction: column;
                  justify-content: center;
                ">
                  <div style="color: #2c3e50; font-size: 0.9em;">Amazon</div>
                  <div><span id="amazonTotal" style="font-weight: bold;">0</span>円</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      `);

      // ナビゲーションボタンのイベントを設定
      $(document).on('click', '.prev-month', () => {
        console.log('Previous month clicked');
        if (this.month === 1) {
          this.year--;
          this.month = 12;
        } else {
          this.month--;
        }
        const targetDate = `${this.year}-${this.month.toString().padStart(2, '0')}-01`;
        console.log('Loading data for:', targetDate);
        this.loadData(targetDate);
      });

      $(document).on('click', '.next-month', () => {
        console.log('Next month clicked');
        if (this.month === 12) {
          this.year++;
          this.month = 1;
        } else {
          this.month++;
        }
        const targetDate = `${this.year}-${this.month.toString().padStart(2, '0')}-01`;
        console.log('Loading data for:', targetDate);
        this.loadData(targetDate);
      });

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
    printType : function(thisYear, thisMonth, skipDataLoad = false) {
        console.log('Printing calendar for:', thisYear, thisMonth);

        // 年月を表示
        let tgtyearmonth = thisYear + '年' + thisMonth+ '月';
        $(this.ele).find('.calendar-year-month').text(tgtyearmonth);

        // 対象月の日付を生成
        var thisDate = new Date(thisYear, thisMonth-1, 1);

        // データの再取得は skipDataLoad が false の時のみ
        if (!skipDataLoad) {
            const targetDate = `${thisYear}-${thisMonth.toString().padStart(2, '0')}-01`;
            this.loadData(targetDate);
            return; // データロード後に再度呼ばれるので、ここで終了
        }

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

        // 対象日付の設定
        const defaultTgtDate = targetDate || `${new Date().getFullYear()}-${(new Date().getMonth() + 1).toString().padStart(2, '0')}-01`;
        console.log('loadData called with date:', defaultTgtDate);

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': csrfToken
            }
        });

        let url = window.routes.moneyJson;
        if (defaultTgtDate) {
            url += `?tgtdate=${defaultTgtDate}`;
        }
        console.log('Requesting URL:', url);

        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            async: true,
            success: function(data) {
                console.log('API Response:', data);

                // データを設定
                self.events = data.event || [];
                self.year = data.year;
                self.month = data.month;
                self.holiday = data.holiday || [];

                // 合計金額を更新
                const monthlyTotal = data.monthlyTotal || 0;
                $('#monthlyTotal').text(monthlyTotal.toLocaleString());

                // 項目別合計を更新
                if (data.itemTotals) {
                    Object.keys(data.itemTotals).forEach(key => {
                        const total = data.itemTotals[key] || 0;
                        $(`#itemTotal${key}`).text(total.toLocaleString());
                    });
                }

                // Amazon合計を更新
                const amazonTotal = data.amazonTotal || 0;
                $('#amazonTotal').text(amazonTotal.toLocaleString());

                // カレンダーを再描画
                self.printType(self.year, self.month, true);
                self.setEvent();

                // デバッグ情報
                console.log('Updated totals:', {
                    monthly: monthlyTotal,
                    items: data.itemTotals,
                    amazon: data.amazonTotal
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("データ取得エラー:", {
                    status: textStatus,
                    error: errorThrown,
                    response: jqXHR.responseText
                });

                // エラー時は合計をクリア
                $('#monthlyTotal').text('0');
                for (let i = 1; i <= 5; i++) {
                    $(`#itemTotal${i}`).text('0');
                }
                $('#amazonTotal').text('0');
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
