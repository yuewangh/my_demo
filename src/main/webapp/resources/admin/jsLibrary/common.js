if (function (a) {
        a.UCMenu = function (b, c) {
            var d = {sidebar: {fixed: !0, rememberToggle: !0, offCanvas: !0}, sideNav: {hover: !1, showNotificationNumbers: "onhover", showArrows: !0, sideNavArrowIcon: "arrowDown", subOpenSpeed: 300, subCloseSpeed: 400, animationEasing: "linear", absoluteUrl: !1, subDir: ""}}, e = this;
            e.settings = {};
            var b = (a(b), b);
            e.init = function () {
                if (e.settings = a.extend({}, d, c), this.transit(), a.support.transition || (a.fn.transition = a.fn.animate), this.sideBarNav()) {}
            }, e.sideBarNav = function () {
                var b = (a(".UCMenu"), a("#sideNav")), c = (b.find("li.current"), b.find("li")), d = b.find("a"), f = b.find("li>ul.sub"), q = f.find("li>a");
                e.settings.sideNav.showArrows && (a("#sideNav").hasClass("show-arrows") || a("#sideNav").addClass("show-arrows"), f.prev("a").find("i.sideNav-arrow").length || f.prev("a").prepend('<i class="' + e.settings.sideNav.sideNavArrowIcon + ' sideNav-arrow"></i>')),
                    c.hover(function () {
                        _this = a(this).children("a"), e.settings.sideNav.hover && _this.hasClass("notExpand") && (_this.next("ul").slideDown(e.settings.sideNav.subOpenSpeed, e.settings.sideNav.animationEasing), _this.next("ul").addClass("show"), _this.addClass("expand").removeClass("notExpand"))
                    }, function () {
                        _this = a(this).children("a"), e.settings.sideNav.hover && _this.hasClass("expand") && (_this.next("ul").removeClass("show"), _this.next("ul").slideUp(e.settings.sideNav.subCloseSpeed, e.settings.sideNav.animationEasing), _this.addClass("notExpand").removeClass("expand"))
                    }), e.settings.sideNav.hover || d.on("click", function (b) {
                    var c = a(this);
                    c.hasClass("notExpand") ? (b.preventDefault(), c.next("ul").slideDown(e.settings.sideNav.subOpenSpeed, e.settings.sideNav.animationEasing), c.next("ul").addClass("show"), c.addClass("expand").removeClass("notExpand"), e.settings.sideNav.showArrows && c.find(".sideNav-arrow").transition({rotate: "-180deg"})) : c.hasClass("expand") && (b.preventDefault(), c.next("ul").removeClass("show"), c.next("ul").slideUp(e.settings.sideNav.subCloseSpeed, e.settings.sideNav.animationEasing), c.addClass("notExpand").removeClass("expand"), e.settings.sideNav.showArrows && c.find(".sideNav-arrow").transition({rotate: "0deg"}))
                }), q.on("click",function(b){
                    //当前
                    var c = a(this);
                    c.hasClass(".active") ? (b.preventDefault()) : (q.removeClass("active"), c.addClass("active"));
                })
            }, e.transit = function () {
                !function (a) {
                    function b(a) {
                        if (a in l.style)return a;
                        var b = ["Moz", "Webkit", "O", "ms"], c = a.charAt(0).toUpperCase() + a.substr(1);
                        if (a in l.style)return a;
                        for (var d = 0; d < b.length; ++d) {
                            var e = b[d] + c;
                            if (e in l.style)return e
                        }
                    }

                    function c() {
                        return l.style[m.transform] = "", l.style[m.transform] = "rotateY(90deg)", "" !== l.style[m.transform]
                    }

                    function d(a) {
                        return"string" == typeof a && this.parse(a), this
                    }

                    function e(a, b, c) {
                        b === !0 ? a.queue(c) : b ? a.queue(b, c) : c()
                    }

                    function f(b) {
                        var c = [];
                        return a.each(b, function (b) {
                            b = a.camelCase(b), b = a.transit.propertyMap[b] || a.cssProps[b] || b, b = i(b), -1 === a.inArray(b, c) && c.push(b)
                        }), c
                    }

                    function g(b, c, d, e) {
                        var g = f(b);
                        a.cssEase[d] && (d = a.cssEase[d]);
                        var h = "" + k(c) + " " + d;
                        parseInt(e, 10) > 0 && (h += " " + k(e));
                        var i = [];
                        return a.each(g, function (a, b) {
                            i.push(b + " " + h)
                        }), i.join(", ")
                    }

                    function h(b, c) {
                        c || (a.cssNumber[b] = !0), a.transit.propertyMap[b] = m.transform, a.cssHooks[b] = {get: function (c) {
                            var d = a(c).css("transit:transform");
                            return d.get(b)
                        }, set: function (c, d) {
                            var e = a(c).css("transit:transform");
                            e.setFromString(b, d), a(c).css({"transit:transform": e})
                        }}
                    }

                    function i(a) {
                        return a.replace(/([A-Z])/g, function (a) {
                            return"-" + a.toLowerCase()
                        })
                    }

                    function j(a, b) {
                        return"string" != typeof a || a.match(/^[\-0-9\.]+$/) ? "" + a + b : a
                    }

                    function k(b) {
                        var c = b;
                        return a.fx.speeds[c] && (c = a.fx.speeds[c]), j(c, "ms")
                    }

                    a.transit = {version: "0.9.9", propertyMap: {marginLeft: "margin", marginRight: "margin", marginBottom: "margin", marginTop: "margin", paddingLeft: "padding", paddingRight: "padding", paddingBottom: "padding", paddingTop: "padding"}, enabled: !0, useTransitionEnd: !1};
                    var l = document.createElement("div"), m = {}, n = navigator.userAgent.toLowerCase().indexOf("chrome") > -1;
                    m.transition = b("transition"), m.transitionDelay = b("transitionDelay"), m.transform = b("transform"), m.transformOrigin = b("transformOrigin"), m.transform3d = c();
                    var o = {transition: "transitionEnd", MozTransition: "transitionend", OTransition: "oTransitionEnd", WebkitTransition: "webkitTransitionEnd", msTransition: "MSTransitionEnd"}, p = m.transitionEnd = o[m.transition] || null;
                    for (var q in m)m.hasOwnProperty(q) && "undefined" == typeof a.support[q] && (a.support[q] = m[q]);
                    l = null, a.cssEase = {_default: "ease", "in": "ease-in", out: "ease-out", "in-out": "ease-in-out", snap: "cubic-bezier(0,1,.5,1)", easeOutCubic: "cubic-bezier(.215,.61,.355,1)", easeInOutCubic: "cubic-bezier(.645,.045,.355,1)", easeInCirc: "cubic-bezier(.6,.04,.98,.335)", easeOutCirc: "cubic-bezier(.075,.82,.165,1)", easeInOutCirc: "cubic-bezier(.785,.135,.15,.86)", easeInExpo: "cubic-bezier(.95,.05,.795,.035)", easeOutExpo: "cubic-bezier(.19,1,.22,1)", easeInOutExpo: "cubic-bezier(1,0,0,1)", easeInQuad: "cubic-bezier(.55,.085,.68,.53)", easeOutQuad: "cubic-bezier(.25,.46,.45,.94)", easeInOutQuad: "cubic-bezier(.455,.03,.515,.955)", easeInQuart: "cubic-bezier(.895,.03,.685,.22)", easeOutQuart: "cubic-bezier(.165,.84,.44,1)", easeInOutQuart: "cubic-bezier(.77,0,.175,1)", easeInQuint: "cubic-bezier(.755,.05,.855,.06)", easeOutQuint: "cubic-bezier(.23,1,.32,1)", easeInOutQuint: "cubic-bezier(.86,0,.07,1)", easeInSine: "cubic-bezier(.47,0,.745,.715)", easeOutSine: "cubic-bezier(.39,.575,.565,1)", easeInOutSine: "cubic-bezier(.445,.05,.55,.95)", easeInBack: "cubic-bezier(.6,-.28,.735,.045)", easeOutBack: "cubic-bezier(.175, .885,.32,1.275)", easeInOutBack: "cubic-bezier(.68,-.55,.265,1.55)"}, a.cssHooks["transit:transform"] = {get: function (b) {
                        return a(b).data("transform") || new d
                    }, set: function (b, c) {
                        var e = c;
                        e instanceof d || (e = new d(e)), b.style[m.transform] = "WebkitTransform" !== m.transform || n ? e.toString() : e.toString(!0), a(b).data("transform", e)
                    }}, a.cssHooks.transform = {set: a.cssHooks["transit:transform"].set}, a.fn.jquery < "1.8" && (a.cssHooks.transformOrigin = {get: function (a) {
                        return a.style[m.transformOrigin]
                    }, set: function (a, b) {
                        a.style[m.transformOrigin] = b
                    }}, a.cssHooks.transition = {get: function (a) {
                        return a.style[m.transition]
                    }, set: function (a, b) {
                        a.style[m.transition] = b
                    }}), h("scale"), h("translate"), h("rotate"), h("rotateX"), h("rotateY"), h("rotate3d"), h("perspective"), h("skewX"), h("skewY"), h("x", !0), h("y", !0), d.prototype = {setFromString: function (a, b) {
                        var c = "string" == typeof b ? b.split(",") : b.constructor === Array ? b : [b];
                        c.unshift(a), d.prototype.set.apply(this, c)
                    }, set: function (a) {
                        var b = Array.prototype.slice.apply(arguments, [1]);
                        this.setter[a] ? this.setter[a].apply(this, b) : this[a] = b.join(",")
                    }, get: function (a) {
                        return this.getter[a] ? this.getter[a].apply(this) : this[a] || 0
                    }, setter: {rotate: function (a) {
                        this.rotate = j(a, "deg")
                    }, rotateX: function (a) {
                        this.rotateX = j(a, "deg")
                    }, rotateY: function (a) {
                        this.rotateY = j(a, "deg")
                    }, scale: function (a, b) {
                        void 0 === b && (b = a), this.scale = a + "," + b
                    }, skewX: function (a) {
                        this.skewX = j(a, "deg")
                    }, skewY: function (a) {
                        this.skewY = j(a, "deg")
                    }, perspective: function (a) {
                        this.perspective = j(a, "px")
                    }, x: function (a) {
                        this.set("translate", a, null)
                    }, y: function (a) {
                        this.set("translate", null, a)
                    }, translate: function (a, b) {
                        void 0 === this._translateX && (this._translateX = 0), void 0 === this._translateY && (this._translateY = 0), null !== a && void 0 !== a && (this._translateX = j(a, "px")), null !== b && void 0 !== b && (this._translateY = j(b, "px")), this.translate = this._translateX + "," + this._translateY
                    }}, getter: {x: function () {
                        return this._translateX || 0
                    }, y: function () {
                        return this._translateY || 0
                    }, scale: function () {
                        var a = (this.scale || "1,1").split(",");
                        return a[0] && (a[0] = parseFloat(a[0])), a[1] && (a[1] = parseFloat(a[1])), a[0] === a[1] ? a[0] : a
                    }, rotate3d: function () {
                        for (var a = (this.rotate3d || "0,0,0,0deg").split(","), b = 0; 3 >= b; ++b)a[b] && (a[b] = parseFloat(a[b]));
                        return a[3] && (a[3] = j(a[3], "deg")), a
                    }}, parse: function (a) {
                        var b = this;
                        a.replace(/([a-zA-Z0-9]+)\((.*?)\)/g, function (a, c, d) {
                            b.setFromString(c, d)
                        })
                    }, toString: function (a) {
                        var b = [];
                        for (var c in this)if (this.hasOwnProperty(c)) {
                            if (!m.transform3d && ("rotateX" === c || "rotateY" === c || "perspective" === c || "transformOrigin" === c))continue;
                            "_" !== c[0] && b.push(a && "scale" === c ? c + "3d(" + this[c] + ",1)" : a && "translate" === c ? c + "3d(" + this[c] + ",0)" : c + "(" + this[c] + ")")
                        }
                        return b.join(" ")
                    }}, a.fn.transition = a.fn.transit = function (b, c, d, f) {
                        var h = this, i = 0, j = !0;
                        "function" == typeof c && (f = c, c = void 0), "function" == typeof d && (f = d, d = void 0), "undefined" != typeof b.easing && (d = b.easing, delete b.easing), "undefined" != typeof b.duration && (c = b.duration, delete b.duration), "undefined" != typeof b.complete && (f = b.complete, delete b.complete), "undefined" != typeof b.queue && (j = b.queue, delete b.queue), "undefined" != typeof b.delay && (i = b.delay, delete b.delay), "undefined" == typeof c && (c = a.fx.speeds._default), "undefined" == typeof d && (d = a.cssEase._default), c = k(c);
                        var l = g(b, c, d, i), n = a.transit.enabled && m.transition, o = n ? parseInt(c, 10) + parseInt(i, 10) : 0;
                        if (0 === o) {
                            var q = function (a) {
                                h.css(b), f && f.apply(h), a && a()
                            };
                            return e(h, j, q), h
                        }
                        var r = {}, s = function (c) {
                            var d = !1, e = function () {
                                d && h.unbind(p, e), o > 0 && h.each(function () {
                                    this.style[m.transition] = r[this] || null
                                }), "function" == typeof f && f.apply(h), "function" == typeof c && c()
                            };
                            o > 0 && p && a.transit.useTransitionEnd ? (d = !0, h.bind(p, e)) : window.setTimeout(e, o), h.each(function () {
                                o > 0 && (this.style[m.transition] = l), a(this).css(b)
                            })
                        }, t = function (a) {
                            this.offsetWidth, s(a)
                        };
                        return e(h, j, t), this
                    }, a.transit.getTransitionValue = g
                }(jQuery)
            };
            e.init()
        }, a.fn.UCMenu = function (b) {
            return this.each(function () {
                if (void 0 == a(this).data("UCMenu")) {
                    var c = new a.UCMenu(this, b);
                    a(this).data("UCMenu", c)
                }
            })
        }
    }(jQuery)){}
var ucmenua = $(document).ready(function () {
    $(".UCMenu a[href^=#]").click(function (a) {
        a.preventDefault()
    }),
        $("body").UCMenu({sideNav: {hover: !1, showNotificationNumbers: "onhover", showArrows: !0, sideNavArrowIcon: "arrowDown", subOpenSpeed: 300, subCloseSpeed: 400, animationEasing: "linear", absoluteUrl: !1, subDir: ""}})
});


window.onload = window.onresize = function(){
    var headerH=$(".header").height();
    var footerH = $(".footer").height();
    var allHeight = $("body").height();
    var containerHeight = headerH + $(".wrap").height() ;
    if(containerHeight < allHeight){
        $(".footer").addClass("fixed");
    }
    else{
        $(".footer").removeClass("fixed");
    }
}