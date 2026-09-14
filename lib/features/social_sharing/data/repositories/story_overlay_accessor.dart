// Indirection to avoid a circular import between the story generator and
// the router. The composition root assigns the accessor at startup.
import 'package:flutter/material.dart';

OverlayState? Function()? storyOverlayAccessor;
