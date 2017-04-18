// import React from "react"
// import ReactDOM from "react-dom"
// 
// export default function reactPhoenix => () {
//   const elements = document.querySelectorAll('[data-react-class]')
//   elements.forEach(e => {
//     const reactElement = React.createElement(eval(e.dataset.reactClass), JSON.parse(e.dataset.reactProps))
//     ReactDOM.render(e, reactElement)
//   })
// }

"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = reactPhoenix;

var _react = require("react");

var _react2 = _interopRequireDefault(_react);

var _reactDom = require("react-dom");

var _reactDom2 = _interopRequireDefault(_reactDom);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function reactPhoenix() {
  var elements = document.querySelectorAll('[data-react-class]');
  elements.forEach(function (e) {
    var reactClass = eval(e.dataset.reactClass);
    var reactProps = e.dataset.reactProps;
    if (reactProps == undefined) {
      reactProps = "{}"
    }
    var reactElement = _react2.default.createElement(reactClass, JSON.parse(reactProps));
    _reactDom2.default.render(reactElement, e);
  });
}
