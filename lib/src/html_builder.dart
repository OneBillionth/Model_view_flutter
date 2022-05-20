/* This is free and unencumbered software released into the public domain. */

import 'dart:convert' show htmlEscape;

import 'package:flutter/material.dart';

import 'flutter_model_viewer.dart';

abstract class HTMLBuilder {
  HTMLBuilder._();

  static String build({
    final String htmlTemplate = '',
    required final String src,
    final Color backgroundColor = const Color(0x00ffffff),
    final String? rotationPerSecond,
    final String? alt,
    final bool? ar,
    final List<String>? arModes,
    final String? arScale,
    final bool? autoRotate,
    final int? autoRotateDelay,
    final bool? autoPlay,
    final bool? cameraControls,
    final String? iosSrc,
    final String? poster,
    final bool? seamlessPoster,
    final bool? withCredentials,
    final TouchAction? touchAction,
    // AR Attributes
    final bool? xrEnvironment,
    // Staing & Cameras Attributes
    final bool? enablePan,
    final bool? disableZoom,
    final int? orbitSensitivity,
    final num? interactionPromptThreshold,
    final String? cameraOrbit,
    final String? cameraTarget,
    final String? fieldOfView,
    final String? maxCameraOrbit,
    final String? minCameraOrbit,
    final String? maxFieldOfView,
    final String? minFieldOfView,
    final num? interpolationDecay,
    // Lighting & Env Attributes
    final String? skyboxImage,
    final String? environmentImage,
    final num? exposure,
    final num? shadowIntensity,
    final num? shadowSoftness,
    // Animation Attributes
    final String? animationName,
    final num? animationCrossfadeDuration,
    // Scene Graph Attributes
    final String? variantName,
    final String? orientation,
    final String? scale,
    final num? minHotspotOpacity,
    final num? maxHotspotOpacity,
  }) {
    final html = StringBuffer(htmlTemplate);
    html.writeln(
        '<style scoped>*{-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}</style>');
    html.write('<model-viewer id="toggle-model"');
    //去除海报闪烁
    html.write(' seamless-poster');
    html.write(' bounds="tight"');

    html.write(' environment-image="neutral"');
    //添加3D资源
    html.write(' src="${htmlEscape.convert(src)}"');
    //关闭演示模式
    html.write(' interaction-prompt="none"');
    //设置触摸滑动方向 xy轴均可
    // html.write(' touch-action="pan-x pan-y"');
    html.write(
        ' style="background-color: rgb(${backgroundColor.red}, ${backgroundColor.green}, ${backgroundColor.blue});"');

    if (alt != null) {
      html.write(' alt="${htmlEscape.convert(alt)}"');
    }
    // xr-environment
    if (xrEnvironment ?? false) {
      html.write(' xr-environment');
    }

    // Staing & Cameras Attributes
    // camera-controls
    if (cameraControls ?? false) {
      html.write(' camera-controls');
    }
    // enable-pan
    if (enablePan ?? false) {
      html.write(' enable-pan');
    }

    // touch-action
    if (touchAction != null) {
      switch (touchAction) {
        case TouchAction.none:
          html.write(' touch-action="none"');
          break;
        case TouchAction.panX:
          html.write(' touch-action="pan-x"');
          break;
        case TouchAction.panY:
          html.write(' touch-action="pan-y"');
          break;
      }
    }

    // disable-zoom
    if (disableZoom ?? false) {
      html.write(' disable-zoom');
    }
    // orbit-sensitivity
    if (orbitSensitivity != null) {
      html.write(' orbit-sensitivity="$orbitSensitivity"');
    }

    // camera-orbit
    if (cameraOrbit != null) {
      html.write(' camera-orbit="${htmlEscape.convert(cameraOrbit)}"');
    }
    // camera-target
    if (cameraTarget != null) {
      html.write(' camera-target="${htmlEscape.convert(cameraTarget)}"');
    }
    // field-of-view
    if (fieldOfView != null) {
      html.write(' field-of-view="${htmlEscape.convert(fieldOfView)}"');
    }
    // max-camera-orbit
    if (maxCameraOrbit != null) {
      html.write(' max-camera-orbit="${htmlEscape.convert(maxCameraOrbit)}"');
    }
    // min-camera-orbit
    if (minCameraOrbit != null) {
      html.write(' max-camera-orbit="${htmlEscape.convert(minCameraOrbit)}"');
    }
    // max-field-of-view
    if (maxFieldOfView != null) {
      html.write(' max-camera-orbit="${htmlEscape.convert(maxFieldOfView)}"');
    }
    // min-field-of-view
    if (minFieldOfView != null) {
      html.write(' max-camera-orbit="${htmlEscape.convert(minFieldOfView)}"');
    }

    if (skyboxImage != null) {
      html.write(' skybox-image="${htmlEscape.convert(skyboxImage)}"');
    }
    // environment-image
    if (environmentImage != null) {
      html.write(
          ' environment-image="${htmlEscape.convert(environmentImage)}"');
    }
    // exposure
    if (exposure != null) {
      if (exposure < 0) {
        throw RangeError('exposure must be any positive value');
      }
      html.write(' exposure="$exposure"');
    }
    // shadow-intensity
    if (shadowIntensity != null) {
      if (shadowIntensity < 0 || shadowIntensity > 1) {
        throw RangeError('shadow-intensity must be between 0 and 1');
      }
      html.write(' shadow-intensity="$shadowIntensity}"');
    }
    // shadow-softness
    if (shadowSoftness != null) {
      if (shadowSoftness < 0 || shadowSoftness > 1) {
        throw RangeError('shadow-softness must be between 0 and 1');
      }
      html.write(' shadow-softness="$shadowSoftness}"');
    }

    // Animation Attributes
    // animation-name
    if (animationName != null) {
      html.write(' animation-name="${htmlEscape.convert(animationName)}"');
    }
    // animation-crossfade-duration
    if (animationCrossfadeDuration != null) {
      if (animationCrossfadeDuration < 0) {
        throw RangeError('shadow-softness must be any number >= 0');
      }
      html.write(' animation-crossfade-duration="$animationCrossfadeDuration"');
    }

    if (variantName != null) {
      html.write(' variant-name="${htmlEscape.convert(variantName)}"');
    }
    // orientation
    if (orientation != null) {
      html.write(' orientation="${htmlEscape.convert(orientation)}"');
    }
    // scale
    if (scale != null) {
      html.write(' scale="${htmlEscape.convert(scale)}"');
    }

    if (ar ?? false) {
      html.write(' ar');
    }
    if (arModes != null) {
      html.write(' ar-modes="${htmlEscape.convert(arModes.join(' '))}"');
    }
    if (arScale != null) {
      html.write(' ar-scale="${htmlEscape.convert(arScale)}"');
    }
    //是否开启自动旋转
    if (autoRotate ?? false) {
      html.write(
          ' auto-rotate rotation-per-second="${rotationPerSecond ?? '40deg'}"');
      //手指离开多久之后开始自动旋转
      if (autoRotateDelay != null) {
        html.write(' auto-rotate-delay="$autoRotateDelay"');
      }
    }
    //自动播放动画
    if (autoPlay ?? false) {
      html.write(' autoplay');
    }
    //开启相机控制
    if (cameraControls ?? false) {
      html.write(' camera-controls');
    }
    if (iosSrc != null) {
      html.write(' ios-src="${htmlEscape.convert(iosSrc)}"');
    }
    html.writeln('>');
    // html.writeln('<div  slot="poster"></div>');
    html.writeln('<div slot="progress-bar"></div slot="">');
    html.writeln('<div slot="interaction-prompt"></div>');
    html.writeln('</model-viewer>');

    //当模型可见时通知外部
    var visibleScript =
        'var modelViewer = document.querySelector("#toggle-model");'
        'var device = navigator.userAgent;'
        'var isAndroid = device.indexOf("Android") > -1 || device.indexOf("Adr") > -1;'
        'var isIOS = !!device.match(/\\(i[^;]+;( U;)? CPU.+Mac OS X/);'
        'modelViewer.addEventListener("model-visibility", (event) => { '
        'if(isAndroid){'
        'ModelVisibility.postMessage(event.detail.visible);'
        '}'
        'if(isIOS){'
        'window.webkit.messageHandlers.ModelVisibility.postMessage(event.detail.visible);'
        '}'
        '}, true);';
    //解决H5在IOS的WebView下上拉下拉会带动整个WebView出现空白
    visibleScript +=
        'document.body.addEventListener("touchmove", function(e) {if(e._isScroller) return;e.preventDefault();}, {passive: false});';
    html.writeln('<script type="text/javascript">$visibleScript</script>');
    return html.toString();
  }
}
