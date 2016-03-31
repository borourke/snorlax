/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
	  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	__webpack_require__(1);

	__webpack_require__(6);

	__webpack_require__(7);

	__webpack_require__(8);

	__webpack_require__(9);

	window.flo || (window.flo = {});

	flo.Workflow = (function(superClass) {
	  extend(Workflow, superClass);

	  function Workflow(id) {
	    this.id = id;
	    this["export"] = bind(this["export"], this);
	    this.dblclick = bind(this.dblclick, this);
	    this.pendingRouteAdded = bind(this.pendingRouteAdded, this);
	    Workflow.__super__.constructor.call(this, this.id);
	    this.bg.on('dblclick', this.dblclick);
	    this.fg.on('pending_route_added', this.pendingRouteAdded);
	  }

	  Workflow.prototype.pendingRouteAdded = function(event) {
	    this.pendingRoute = event.target._flo.pendingRoute;
	    this.highlightNodes();
	    return this.stage.update();
	  };

	  Workflow.prototype.dblclick = function(event) {
	    return this.addNode(new flo.Job('######', event.stageX, event.stageY));
	  };

	  Workflow.prototype.clear = function() {
	    this.routes = [];
	    return Workflow.__super__.clear.call(this);
	  };

	  Workflow.prototype.addRoute = function(route) {
	    this.routes.push(route);
	    return this.addEdge(route);
	  };

	  Workflow.prototype.addGate = function(name, route) {
	    route.addGate(name);
	    return this.stage.update();
	  };

	  Workflow.prototype.highlightNodes = function() {
	    var i, len, node, ref;
	    ref = this.nodes;
	    for (i = 0, len = ref.length; i < len; i++) {
	      node = ref[i];
	      node.highlight();
	      node.shape.on('click', this.pendingRouteDefined, this, false, {
	        nodeA: this.pendingRoute.nodeA,
	        nodeB: node
	      });
	    }
	    return this.stage.update();
	  };

	  Workflow.prototype.pendingRouteDefined = function(event, nodes) {
	    this.dehighlightNodes();
	    return this.addRoute(new flo.Route(nodes.nodeA, nodes.nodeB));
	  };

	  Workflow.prototype.dehighlightNodes = function() {
	    var i, len, node, ref;
	    ref = this.nodes;
	    for (i = 0, len = ref.length; i < len; i++) {
	      node = ref[i];
	      node.dehighlight();
	      node.shape.off('click');
	    }
	    return this.stage.update();
	  };

	  Workflow.prototype["export"] = function(nodes) {
	    return JSON.stringify(this.nodes.map(function(node) {
	      return {
	        name: node.name,
	        routes: node.routesTo(),
	        x: node.x,
	        y: node.y
	      };
	    }));
	  };

	  Workflow.prototype["import"] = function(str) {
	    var i, j, len, len1, node, nodes, results, route, routeObj;
	    this.clear();
	    nodes = JSON.parse(str);
	    for (i = 0, len = nodes.length; i < len; i++) {
	      node = nodes[i];
	      this.addNode(new flo.Job(node.name, node.x, node.y));
	    }
	    results = [];
	    for (j = 0, len1 = nodes.length; j < len1; j++) {
	      node = nodes[j];
	      results.push((function() {
	        var k, len2, ref, results1;
	        ref = node.routes;
	        results1 = [];
	        for (k = 0, len2 = ref.length; k < len2; k++) {
	          route = ref[k];
	          routeObj = new flo.Route(this.getNode(node.name), this.getNode(route.node));
	          this.addRoute(routeObj);
	          if (route.gate) {
	            results1.push(this.addGate(route.gate, routeObj));
	          } else {
	            results1.push(void 0);
	          }
	        }
	        return results1;
	      }).call(this));
	    }
	    return results;
	  };

	  return Workflow;

	})(flo.Chart);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

	__webpack_require__(2);

	__webpack_require__(3);

	__webpack_require__(4);

	__webpack_require__(5);

	window.flo || (window.flo = {});

	flo.Chart = (function() {
	  function Chart(id) {
	    this.id = id;
	    this.onDrag = bind(this.onDrag, this);
	    this.$canvas = $('#' + this.id);
	    this.stage = new createjs.Stage(this.id);
	    this.bg = new createjs.Shape();
	    this.bg.graphics.beginFill('white').drawRect(0, 0, this.$canvas.width(), this.$canvas.height());
	    this.stage.addChild(this.bg);
	    this.fg = new createjs.MovieClip();
	    this.stage.addChild(this.fg);
	    this.clear();
	  }

	  Chart.prototype.clear = function() {
	    this.fg.removeAllChildren();
	    this.nodes = [];
	    this.edges = [];
	    return this.stage.update();
	  };

	  Chart.prototype.addNode = function(node) {
	    this.nodes.push(node);
	    node.chart = this;
	    this.fg.addChild(node.shape);
	    this.stage.update();
	    return node.on('pressmove', this.onDrag);
	  };

	  Chart.prototype.onDrag = function(event) {
	    event.currentTarget.x = event.stageX;
	    event.currentTarget.y = event.stageY;
	    event.currentTarget._flo.update();
	    return this.stage.update();
	  };

	  Chart.prototype.addEdge = function(edge) {
	    this.edges.push(edge);
	    this.fg.addChildAt(edge.shape, 0);
	    return this.stage.update();
	  };

	  Chart.prototype.getNode = function(name) {
	    return this.nodes.find(function(node) {
	      return node.name === name;
	    });
	  };

	  return Chart;

	})();


/***/ },
/* 2 */
/***/ function(module, exports) {

	window.flo || (window.flo = {});

	flo.Sprite = (function() {
	  function Sprite() {
	    this.shape = new createjs.MovieClip();
	    this.shape['_flo'] = this;
	    this.bg = new createjs.Shape();
	    this.shape.addChild(this.bg);
	    if (this.name) {
	      this.label = new flo.Label(this.name);
	      this.shape.addChild(this.label.shape);
	    }
	    this.draw();
	  }

	  Sprite.prototype.draw = function() {
	    return this.bg.graphics.clear();
	  };

	  Sprite.prototype.addChild = function(child) {
	    return this.shape.addChild(child.shape);
	  };

	  Sprite.prototype.on = function(event, func) {
	    return this.shape.on(event, func);
	  };

	  return Sprite;

	})();


/***/ },
/* 3 */
/***/ function(module, exports) {

	window.flo || (window.flo = {});

	flo.Label = (function() {
	  function Label(name) {
	    this.shape = new createjs.Text(name, "14px Arial");
	    this.shape.x = this.shape.getMeasuredWidth() / -2;
	    this.shape.y = this.shape.getMeasuredHeight() / -2;
	  }

	  return Label;

	})();


/***/ },
/* 4 */
/***/ function(module, exports) {

	var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.Edge = (function(superClass) {
	  extend(Edge, superClass);

	  function Edge(nodeA, nodeB) {
	    this.nodeA = nodeA;
	    this.nodeB = nodeB;
	    Edge.__super__.constructor.call(this);
	    this.nodeA.addEdge(this);
	    this.nodeB.addEdge(this);
	  }

	  Edge.prototype.draw = function() {
	    Edge.__super__.draw.call(this);
	    return this.bg.graphics.beginStroke('black').moveTo(this.nodeA.x, this.nodeA.y).lineTo(this.nodeB.x, this.nodeB.y);
	  };

	  return Edge;

	})(flo.Sprite);


/***/ },
/* 5 */
/***/ function(module, exports) {

	var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.Node = (function(superClass) {
	  extend(Node, superClass);

	  function Node(name, x, y) {
	    this.name = name;
	    this.x = x;
	    this.y = y;
	    this.chart = null;
	    Node.__super__.constructor.call(this);
	    this.edges = [];
	    this.shape.x = this.x;
	    this.shape.y = this.y;
	  }

	  Node.prototype.draw = function() {
	    Node.__super__.draw.call(this);
	    return this.bg.graphics.beginStroke('black').beginFill('white').drawCircle(0, 0, 40);
	  };

	  Node.prototype.addEdge = function(edge) {
	    return this.edges.push(edge);
	  };

	  Node.prototype.update = function() {
	    var edge, i, len, ref, results;
	    this.x = this.shape.x;
	    this.y = this.shape.y;
	    ref = this.edges;
	    results = [];
	    for (i = 0, len = ref.length; i < len; i++) {
	      edge = ref[i];
	      results.push(edge.draw());
	    }
	    return results;
	  };

	  Node.prototype.highlight = function() {
	    return this.bg.graphics.beginFill('#EEFFEE').drawCircle(0, 0, 39);
	  };

	  Node.prototype.dehighlight = function() {
	    return this.draw();
	  };

	  return Node;

	})(flo.Sprite);


/***/ },
/* 6 */
/***/ function(module, exports) {

	var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.Gate = (function(superClass) {
	  extend(Gate, superClass);

	  function Gate(name, route) {
	    this.name = name;
	    this.route = route;
	    Gate.__super__.constructor.call(this);
	    this.bg.graphics.beginStroke('black').beginFill('white').drawCircle(0, 0, 20);
	    this.draw();
	  }

	  Gate.prototype.draw = function() {
	    this.shape.x = this.route.nodeA.x + (this.route.nodeB.x - this.route.nodeA.x) / 2;
	    return this.shape.y = this.route.nodeA.y + (this.route.nodeB.y - this.route.nodeA.y) / 2;
	  };

	  return Gate;

	})(flo.Sprite);


/***/ },
/* 7 */
/***/ function(module, exports) {

	var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.Route = (function(superClass) {
	  extend(Route, superClass);

	  function Route(nodeA, nodeB) {
	    this.nodeA = nodeA;
	    this.nodeB = nodeB;
	    Route.__super__.constructor.call(this, this.nodeA, this.nodeB);
	  }

	  Route.prototype.draw = function() {
	    if (this.gate) {
	      this.gate.draw();
	    }
	    return Route.__super__.draw.call(this);
	  };

	  Route.prototype.addGate = function(name) {
	    this.gate = new flo.Gate(name, this);
	    return this.addChild(this.gate);
	  };

	  return Route;

	})(flo.Edge);


/***/ },
/* 8 */
/***/ function(module, exports) {

	var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.PendingRoute = (function(superClass) {
	  extend(PendingRoute, superClass);

	  function PendingRoute(nodeA) {
	    this.nodeA = nodeA;
	    PendingRoute.__super__.constructor.call(this, this.nodeA, this.nodeA);
	  }

	  return PendingRoute;

	})(flo.Route);


/***/ },
/* 9 */
/***/ function(module, exports) {

	var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
	  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
	  hasProp = {}.hasOwnProperty;

	window.flo || (window.flo = {});

	flo.Job = (function(superClass) {
	  extend(Job, superClass);

	  function Job(name, x, y) {
	    this.name = name;
	    this.x = x;
	    this.y = y;
	    this.addPendingRoute = bind(this.addPendingRoute, this);
	    Job.__super__.constructor.call(this, this.name, this.x, this.y);
	    this.on('dblclick', this.addPendingRoute);
	  }

	  Job.prototype.addPendingRoute = function(event) {
	    this.pendingRoute = new flo.PendingRoute(this);
	    return this.shape.dispatchEvent('pending_route_added', true);
	  };

	  Job.prototype.addRoute = function(route) {
	    return this.addEdge(route);
	  };

	  Job.prototype.routesTo = function() {
	    return this.edges.filter((function(_this) {
	      return function(route) {
	        return route.nodeA === _this;
	      };
	    })(this)).map((function(_this) {
	      return function(route) {
	        return {
	          node: route.nodeB.name,
	          gate: route.gate ? route.gate.name : void 0
	        };
	      };
	    })(this));
	  };

	  return Job;

	})(flo.Node);


/***/ }
/******/ ]);