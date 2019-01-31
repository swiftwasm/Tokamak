//
//  UIValueComponent.swift
//  GluonUIKit
//
//  Created by Max Desiatov on 29/12/2018.
//

import Gluon
import UIKit

protocol UIValueComponent: UIControlComponent
  where Props: ValueControlProps, Target: ValueStorage,
  Props.Value == Target.Value {
  static func update(valueBox: ValueControlBox<Target>,
                     _ props: Props,
                     _ children: Children)
}

extension UIValueComponent {
  static func box(
    for view: Target,
    _ viewController: UIViewController,
    _ component: UIKitRenderer.MountedHost,
    _: UIKitRenderer
  ) -> ViewBox<Target> {
    return ValueControlBox(view, viewController, component.node)
  }

  static func update(control box: ControlBox<Target>,
                     _ props: Props,
                     _ children: Children) {
    guard let box = box as? ValueControlBox<Target> else { return }

    update(valueBox: box, props, children)
    box.value = props.value
    box.bind(valueChangedHandler: props.valueHandler)
  }
}
