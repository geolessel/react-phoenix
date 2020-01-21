import React from "react"
import ReactDOM from "react-dom"

export default class ReactPhoenix {
  static init() {
    const elements = document.querySelectorAll('[data-react-class]')
    Array.prototype.forEach.call(elements, e => {
      const targetId = document.getElementById(e.dataset.reactTargetId)
      const targetDiv = targetId ? targetId : e
      const reactProps = e.dataset.reactProps ? e.dataset.reactProps : "{}"
      const reactClass = Array.prototype.reduce.call(e.dataset.reactClass.split('.'), (acc, el) => { return acc[el] }, window);
      const reactElement = React.createElement(reactClass, JSON.parse(reactProps))
      ReactDOM.render(reactElement, targetDiv)
    })
  }
}

document.addEventListener("DOMContentLoaded", e => {
  ReactPhoenix.init()
})
