/***********************************************************************
This is a simple plugin to allow you to toggle an element between
position: absolute and position: fixed based on the window scroll
position. This lets you have an apparently inline element which floats
to stay on the screen once it would otherwise scroll off the screen.

Author: Chris Heald (cheald@mashable.com)

Copyright (c) 2011, Chris Heald All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer. Redistributions in
binary form must reproduce the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution. Neither the name of the
project nor the names of its contributors may be used to endorse or
promote products derived from this software without specific prior
written permission. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

***********************************************************************/

(function($) {
  var triggers = [];
  $.fn.floatingFixed = function(options) {
    options = $.extend({}, $.floatingFixed.defaults, options);
    var r = $(this).each(function() {
      var $this = $(this), pos = $this.position();
      pos.position = $this.css("position");
	  pos.height = $this.height();
	  var pageContentHeight = $('article.show').height(),
		  pageContentPosition = $('article.show').position(),
		  topPageHeight = $('nav#top_page').height(),
		  pageContentBottom = pageContentPosition.top + pageContentHeight;
		
      $this.data("floatingFixedOrig", pos);
	alert("début: " + pageContentHeight);
	  $this.data("floatFixedEnd", pageContentBottom - (pos.height + topPageHeight));
		
      $this.data("floatingFixedOptions", options);
      triggers.push($this);
    });
    windowScroll();
    return r;
  };

  $.floatingFixed = $.fn.floatingFixed;
  $.floatingFixed.defaults = {
    padding: 0
  };

  var $window = $(window);
  var windowScroll = function() {
    if(triggers.length === 0) { return; }
    var scrollY = $window.scrollTop();
    for(var i = 0; i < triggers.length; i++) {
      var t = triggers[i], opt = t.data("floatingFixedOptions"), origin = t.data("floatingFixedOrig"), end = t.data("floatFixedEnd");
      if(!t.data("isFloating") && !t.data("hasEnded")) {
        var off = t.offset();
        t.data("floatingFixedTop", off.top);
        t.data("floatingFixedLeft", off.left);
      }
      var top = top = t.data("floatingFixedTop");

		// When scroll pass the level which is fixing the share bar on the screen going down
      if(top <= scrollY + opt.padding && !t.data("isFloating") && end >= scrollY + opt.padding) {
        t.css({position: 'fixed', top: opt.padding, left: t.data("floatingFixedLeft"), width: t.width() }).data("isFloating", true).data("hasEnded", true);
      	// alert("Case 1");
      } // When the scroll pass on the top of the level which is putting back the share bar to origin place
		else if(top > scrollY + opt.padding && t.data("isFloating")) {
        
        t.css({position:'static', top: origin.top, left: origin.left, width: t.width()}).data("isFloating", false).data("hasEnded", true);
		// alert("Case 2: " + origin.top);
      } // When the scroll pass the end level which is keeping the share bar at the end point
		else if(end < scrollY + opt.padding && t.data("isFloating")) {
		t.css({position: 'absolute', top: end, left: t.data("floatingFixedLeft"), width: t.width() }).data("isFloating", false).data("hasEnded", true);
		alert("Case 3");
      }
    }
  };

  $window.scroll(windowScroll).resize(windowScroll);
})(jQuery);