import React from "react"
import ReactDOM from "react-dom"

export default class ReactPhoenix {
  static init() {
    const elements = document.querySelectorAll('[data-react-class]')
    Array.prototype.forEach.call(elements, e => ReactPhoenix.renderElement({el: e}))
  }

  static renderElement({ el, pushEvent, handleEvent }) {
    const targetId = document.getElementById(el.dataset.reactTargetId)
    const targetDiv = targetId ? targetId : el
    const reactProps = el.dataset.reactProps ? el.dataset.reactProps : "{}"
    const reactClass = Array.prototype.reduce.call(el.dataset.reactClass.split('.'), (acc, elem) => { return acc[elem] }, window);
    const jsonProps = { ...JSON.parse(reactProps), handleEvent, pushEvent }
    const reactElement = React.createElement(reactClass, jsonProps)
    ReactDOM.render(reactElement, targetDiv)
  }

  static mounted() {
    const pushEvent = this.pushEvent.bind(this)
    const handleEvent = this.handleEvent.bind(this)
    ReactPhoenix.renderElement({...this, handleEvent, pushEvent})
  }

  static destroyed() {
    ReactDOM.unmountComponentAtNode(this.el)
  }
}

document.addEventListener("DOMContentLoaded", e => {
  ReactPhoenix.init()
})
